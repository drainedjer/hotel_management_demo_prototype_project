-- =============================================================================
-- HavenStay: Sample Seed Data for rental_management_db
-- Demo passwords (bcrypt hashed):
--   owner@havenstay.demo / Owner123!
--   admin@havenstay.demo / Admin123!
--   staff@havenstay.demo / Staff123!
-- =============================================================================

USE rental_management_db;

INSERT INTO users (id, full_name, email, password_hash, role, phone) VALUES
(1, 'Lance Caringal', 'owner@havenstay.demo', '$2b$10$CwTycUXWue0Thq9StjUM0uJ8uW7fV4xM2Q6cE5rN7iF6B3d7v7sK6', 'owner', '+63 917 555 0101'),
(2, 'Jeremy Cedrick Rodriguez', 'admin@havenstay.demo', '$2b$10$CwTycUXWue0Thq9StjUM0uJ8uW7fV4xM2Q6cE5rN7iF6B3d7v7sK6', 'admin', '+63 917 555 0102'),
(3, 'Christian Jacob Semira', 'staff@havenstay.demo', '$2b$10$CwTycUXWue0Thq9StjUM0uJ8uW7fV4xM2Q6cE5rN7iF6B3d7v7sK6', 'staff', '+63 917 555 0103');

INSERT INTO owners (id, user_id, business_name, tax_id, billing_address) VALUES
(1, 1, 'HavenStay Property Holdings', 'TIN-402-881-990', '248 Ayala Avenue, Makati City');

INSERT INTO expense_categories (id, name, description) VALUES
(1, 'Electricity', 'Monthly electric utility charges'),
(2, 'Water', 'Water district billing'),
(3, 'Internet', 'Fiber internet and Wi-Fi routers'),
(4, 'Maintenance', 'Routine preventive maintenance'),
(5, 'Repairs', 'Plumbing, electrical, and fixture repairs'),
(6, 'Cleaning', 'Common area janitorial services'),
(7, 'Supplies', 'Consumables and hardware supplies'),
(8, 'Employee Salary', 'Caretaker and staff payroll'),
(9, 'Taxes', 'Local property and business taxes'),
(10, 'Other Expenses', 'Miscellaneous operational expenses');

INSERT INTO amenities (id, name) VALUES
(1, 'High-Speed Fiber Wi-Fi'),
(2, '24/7 CCTV & Keycard Access'),
(3, 'Air Conditioning'),
(4, 'Study Lounge'),
(5, 'Laundry Room'),
(6, 'Shared Kitchen'),
(7, 'Backup Generator'),
(8, 'Bike & Scooter Parking');

INSERT INTO properties (id, owner_id, name, property_type, address, city, latitude, longitude, description, monthly_price, house_rules, is_published, contact_phone, contact_email) VALUES
(1, 1, 'Emerald Crest Residences', 'Apartment', '42 Salcedo Street, Legazpi Village', 'Makati City', 14.5547000, 121.0185000, 'Sunlit mid-rise apartments designed for young professionals and graduate students within walking distance of parks and transit hubs.', 18500.00, 'Quiet hours 10:00 PM - 6:00 AM|No smoking indoors|Guests must sign in at reception', 1, '+63 917 555 0101', 'leasing@havenstay.demo'),
(2, 1, 'Oakwood University Dormitory', 'Dormitory', '118 Taft Avenue, Malate', 'Manila', 14.5682000, 120.9936000, 'Purpose-built student dormitory steps from university gates featuring dedicated study halls, biometric entry, and high-speed fiber Wi-Fi.', 6500.00, 'Curfew sign-in after 11:30 PM|No cooking appliances inside bedrooms|Keep study lounge clean', 1, '+63 917 555 0101', 'dorm@havenstay.demo'),
(3, 1, 'Harborview Studio Suites', 'Studio Unit', '88 Burgos Circle, BGC', 'Taguig City', 14.5515000, 121.0451000, 'Fully furnished private studio units with solid oak study desks, blackout curtains, ensuite bath, and floor-to-ceiling city views.', 22000.00, 'No pets allowed|Monthly filter inspection scheduled|Observe garbage segregation', 1, '+63 917 555 0101', 'studios@havenstay.demo'),
(4, 1, 'Maple Grove Boarding House', 'Boarding House', '15 Maginhawa Street, Teachers Village', 'Quezon City', 14.6461000, 121.0617000, 'Warm community boarding house near Diliman campus offering private and shared rooms with communal dining and garden courtyard.', 5800.00, 'Shared kitchen clean-as-you-go|Quiet hours after 10:30 PM|Visitors allowed until 9:00 PM', 1, '+63 917 555 0101', 'maple@havenstay.demo');

INSERT INTO buildings (id, property_id, name, floors, description) VALUES
(1, 1, 'Tower A - Salcedo Wing', 6, 'Primary apartment building'),
(2, 2, 'North Academic Hall', 4, 'Student dormitory rooms and second-floor study commons'),
(3, 3, 'Harborview Main Block', 8, 'Furnished studio apartments'),
(4, 4, 'Maple Main House', 3, 'Residential boarding house wing');

INSERT INTO rooms (id, property_id, building_id, floor_number, room_number, room_type, capacity, occupied_beds, monthly_price, status, description) VALUES
(1, 1, 1, 2, 'A-201', 'Apartment', 2, 2, 18500.00, 'Occupied', 'Corner 1-bedroom apartment with balcony'),
(2, 1, 1, 3, 'A-302', 'Apartment', 2, 0, 19000.00, 'Available', 'Bright 1-bedroom unit overlooking street trees'),
(3, 2, 2, 2, 'D-201', 'Dormitory', 4, 3, 6500.00, 'Available', '4-bed student suite with individual study desks and lockers'),
(4, 2, 2, 2, 'D-202', 'Dormitory', 4, 4, 6500.00, 'Occupied', '4-bed student suite facing courtyard'),
(5, 2, 2, 3, 'D-301', 'Private Room', 1, 0, 9800.00, 'Reserved', 'Single occupancy private dorm room'),
(6, 3, 3, 5, 'S-501', 'Studio Unit', 1, 1, 22000.00, 'Occupied', 'Furnished executive studio with workspace'),
(7, 3, 3, 6, 'S-604', 'Studio Unit', 1, 0, 22500.00, 'Available', 'High-floor sunlit studio suite'),
(8, 4, 4, 1, 'M-101', 'Shared Room', 2, 1, 5800.00, 'Available', 'Twin-sharing room near kitchen'),
(9, 4, 4, 2, 'M-204', 'Private Room', 1, 0, 8200.00, 'Maintenance', 'Undergoing AC servicing');

INSERT INTO tenants (id, full_name, email, contact_number, address, emergency_contact, property_id, room_id, move_in_date, monthly_rent, security_deposit, status) VALUES
(1, 'Marco Santos', 'marco.santos@example.edu', '+63 918 221 4401', 'Batangas City', 'Lorna Santos (+63 917 889 1122)', 1, 1, '2026-06-01', 18500.00, 37000.00, 'Active'),
(2, 'Camille Navarro', 'camille.n@example.edu', '+63 917 412 8890', 'Laguna', 'Ramon Navarro (+63 918 332 1019)', 2, 3, '2026-08-15', 6500.00, 6500.00, 'Active'),
(3, 'Joshua Lim', 'joshua.lim@example.edu', '+63 919 601 7742', 'Cavite', 'Grace Lim (+63 917 901 3344)', 2, 4, '2026-08-15', 6500.00, 6500.00, 'Active'),
(4, 'Bea Alcantara', 'bea.alcantara@example.com', '+63 917 773 9102', 'Pampanga', 'Nestor Alcantara (+63 917 311 4520)', 3, 6, '2026-07-01', 22000.00, 44000.00, 'Active'),
(5, 'Daniela Cruz', 'daniela.cruz@example.edu', '+63 920 519 2041', 'Bulacan', 'Teresa Cruz (+63 918 441 7788)', 4, 8, '2026-09-01', 5800.00, 5800.00, 'Active');

INSERT INTO rental_applications (id, reference_number, full_name, email, contact_number, property_id, preferred_room_type, assigned_room_id, expected_move_in_date, occupants, message, status) VALUES
(1, 'APP-2026-1041', 'Gabriel Torres', 'gabriel.torres@example.edu', '+63 917 802 1190', 2, 'Dormitory', 3, '2026-12-01', 1, 'Incoming engineering student looking for a quiet 4-bed dorm slot.', 'Pending'),
(2, 'APP-2026-1042', 'Andrea Bautista', 'andrea.b@example.com', '+63 918 991 3402', 3, 'Studio Unit', 7, '2026-12-10', 1, 'Remote product designer seeking a quiet studio near BGC.', 'Approved');

INSERT INTO payments (id, tenant_id, property_id, room_id, billing_month, due_date, payment_date, amount_due, amount_paid, remaining_balance, payment_method, status, reference_number, receipt_number) VALUES
(1, 1, 1, 1, '2026-11', '2026-11-05', '2026-11-03', 18500.00, 18500.00, 0.00, 'Bank Transfer', 'Paid', 'TXN-202611-001', 'RCPT-2026-0001'),
(2, 2, 2, 3, '2026-11', '2026-11-05', '2026-11-04', 6500.00, 6500.00, 0.00, 'GCash', 'Paid', 'TXN-202611-002', 'RCPT-2026-0002'),
(3, 3, 2, 4, '2026-11', '2026-11-05', '2026-11-07', 6500.00, 4000.00, 2500.00, 'Maya', 'Partial', 'TXN-202611-003', 'RCPT-2026-0003'),
(4, 4, 3, 6, '2026-11', '2026-11-05', '2026-11-02', 22000.00, 22000.00, 0.00, 'Bank Transfer', 'Paid', 'TXN-202611-004', 'RCPT-2026-0004'),
(5, 5, 4, 8, '2026-11', '2026-11-05', NULL, 5800.00, 0.00, 5800.00, 'Cash', 'Overdue', 'TXN-202611-005', 'RCPT-2026-0005');

INSERT INTO expenses (id, property_id, category_id, description, amount, expense_date, payment_method, receipt_reference) VALUES
(1, 1, 1, 'Common area electricity bill - Nov', 6400.00, '2026-11-06', 'Bank Transfer', 'EXP-2026-101'),
(2, 2, 3, 'Dual-fiber 500Mbps student internet', 4500.00, '2026-11-04', 'GCash', 'EXP-2026-102'),
(3, 3, 8, 'Building receptionist & maintenance salary', 14000.00, '2026-11-15', 'Bank Transfer', 'EXP-2026-103'),
(4, 4, 5, 'Room M-204 AC compressor repair', 3200.00, '2026-11-10', 'Cash', 'EXP-2026-104');
