/* site.js - customer portal: search, cards, map, details modal, application form */
let map, markerLayer, current = [];

function initMap() {
  map = L.map('map').setView([14.59, 121.0], 11);
  L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution: '© OpenStreetMap contributors', maxZoom: 19 }).addTo(map);
  markerLayer = L.layerGroup().addTo(map);
}

function drawMap(list) {
  markerLayer.clearLayers();
  list.forEach((p) => {
    L.marker([p.latitude, p.longitude]).addTo(markerLayer).bindPopup(
      `<strong>${esc(p.name)}</strong><br>${money(p.monthlyPrice)}/mo<br><a href="#" data-details="${p.id}">View details</a>`);
  });
  if (list.length) map.fitBounds(list.map((p) => [p.latitude, p.longitude]), { padding: [40, 40], maxZoom: 14 });
}

function cardHtml(p) {
  const tags = p.amenities.slice(0, 3).map((a) => `<span class="badge">${esc(a)}</span>`).join('');
  return `<article class="card"><img loading="lazy" src="${esc(p.images[0])}" alt="${esc(p.name)}">
    <div class="body"><span class="badge b-info" style="align-self:flex-start">${esc(p.propertyType)}</span>
    <h3>${esc(p.name)}</h3><div class="muted">📍 ${esc(p.city)}</div>
    <div class="price">${money(p.monthlyPrice)} <small>/ month</small></div>
    <div class="muted">${p.availableRoomsCount} of ${p.totalRoomsCount} rooms available</div>
    <div class="tags">${tags}</div>
    <p class="muted" style="margin:4px 0">${esc(p.description.slice(0, 95))}…</p>
    <button class="btn" data-details="${p.id}">View details</button></div></article>`;
}

async function loadProperties() {
  const params = new URLSearchParams();
  ['q', 'type', 'minPrice', 'maxPrice', 'occupants', 'amenity'].forEach((id) => { const v = $('#' + id).value.trim(); if (v) params.set(id, v); });
  if ($('#onlyAvailable').checked) params.set('onlyAvailable', 'true');
  try {
    current = await api('/public/properties?' + params);
    $('#count').textContent = `${current.length} propert${current.length === 1 ? 'y' : 'ies'} found`;
    $('#cards').innerHTML = current.length ? current.map(cardHtml).join('') : '<div class="empty">No properties match your filters.</div>';
    drawMap(current);
  } catch (e) { $('#cards').innerHTML = `<div class="empty">${esc(e.message)}</div>`; }
}

async function openDetails(id) {
  const p = await api('/public/properties/' + id);
  const imgs = p.images.length ? p.images : [];
  const rooms = p.rooms.map((r) => `<tr><td>${esc(r.roomNumber)}</td><td>${esc(r.roomType)}</td><td>${r.availableBeds}/${r.capacity}</td><td>${money(r.monthlyPrice)}</td><td>${badge(r.status)}</td></tr>`).join('');
  const m = openModal(`<div class="modal-head"><h2>${esc(p.name)}</h2><button class="x" data-close aria-label="Close">×</button></div>
    <div class="gallery"><img src="${esc(imgs[0] || '')}" alt=""><img src="${esc(imgs[1] || imgs[0] || '')}" alt=""></div>
    <p><span class="badge b-info">${esc(p.propertyType)}</span> <span class="muted">${esc(p.address)}, ${esc(p.city)}</span></p>
    <div class="price">${money(p.monthlyPrice)} <small>/ month</small></div><p>${esc(p.description)}</p>
    <h3>Rooms</h3><div style="overflow:auto"><table class="t"><tr><th>Room</th><th>Type</th><th>Beds free</th><th>Price</th><th>Status</th></tr>${rooms}</table></div>
    <h3 style="margin-top:14px">Amenities</h3><div class="tags">${p.amenities.map((a) => `<span class="badge">${esc(a)}</span>`).join('')}</div>
    <h3 style="margin-top:14px">House rules</h3><ul>${p.houseRules.map((r) => `<li>${esc(r)}</li>`).join('')}</ul>
    <p class="muted">Contact: ${esc(p.contactPhone)} · ${esc(p.contactEmail)}</p>
    <div id="miniMap" style="height:200px;border-radius:10px;margin:10px 0"></div>
    <button class="btn" id="applyBtn">Apply for this property</button>`);
  const mm = L.map($('#miniMap', m)).setView([p.latitude, p.longitude], 15);
  L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution: '© OpenStreetMap contributors' }).addTo(mm);
  L.marker([p.latitude, p.longitude]).addTo(mm);
  $('#applyBtn', m).onclick = () => { m.remove(); openApply(p); };
}

function openApply(p) {
  const types = ['Apartment', 'Dormitory', 'Boarding House', 'Studio Unit', 'Shared Room', 'Private Room'];
  const minDate = new Date().toISOString().slice(0, 10);
  const m = openModal(`<div class="modal-head"><h2>Apply: ${esc(p.name)}</h2><button class="x" data-close aria-label="Close">×</button></div>
    <form id="applyForm"><div class="grid2">
    <div class="field"><label>Full name *</label><input name="fullName" required></div>
    <div class="field"><label>Email *</label><input name="email" type="email" required></div>
    <div class="field"><label>Contact number *</label><input name="contactNumber" required></div>
    <div class="field"><label>Preferred room type</label><select name="preferredRoomType">${types.map((t) => `<option ${t === p.propertyType ? 'selected' : ''}>${t}</option>`).join('')}</select></div>
    <div class="field"><label>Expected move-in *</label><input name="expectedMoveInDate" type="date" min="${minDate}" required></div>
    <div class="field"><label>Occupants</label><input name="occupants" type="number" min="1" max="10" value="1"></div></div>
    <div class="field"><label>Message</label><textarea name="message" rows="3" maxlength="500"></textarea></div>
    <button class="btn" type="submit">Submit application</button></form>`);
  $('#applyForm', m).onsubmit = async (e) => {
    e.preventDefault();
    const body = Object.fromEntries(new FormData(e.target));
    body.propertyId = p.id;
    try {
      const r = await api('/public/applications', { method: 'POST', body });
      $('.modal', m).innerHTML = `<h2>Application received 🎉</h2><p>Your reference number:</p><div class="ref">${esc(r.referenceNumber)}</div>
        <p class="muted">Status: ${esc(r.status)}. Keep this number; the owner will contact you.</p><button class="btn" data-close>Done</button>`;
    } catch (err) { toast(err.message, true); }
  };
}

document.addEventListener('click', (e) => {
  const d = e.target.closest('[data-details]');
  if (d) { e.preventDefault(); openDetails(d.dataset.details).catch((x) => toast(x.message, true)); }
});
$('#burger').onclick = () => $('#navLinks').classList.toggle('open');
$('#navLinks').onclick = () => $('#navLinks').classList.remove('open');

let timer;
$('#filters').addEventListener('input', () => { clearTimeout(timer); timer = setTimeout(loadProperties, 250); });
$('#onlyAvailable').onchange = $('#amenity').onchange = loadProperties;
$('#reset').onclick = () => { $('#filters').reset(); $('#onlyAvailable').checked = false; $('#amenity').value = ''; loadProperties(); };

(async function start() {
  initMap();
  await loadProperties();
  const all = [...new Set(current.flatMap((p) => p.amenities))].sort();
  $('#amenity').innerHTML = '<option value="">Any amenity</option>' + all.map((a) => `<option>${esc(a)}</option>`).join('');
})();
