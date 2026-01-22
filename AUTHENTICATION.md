
# Authentication System Documentation

## Overview
Bangali Enterprise uses a role-based authentication system with four primary roles:
1. **Owner**: Full access to their business entity.
2. **Manager**: Operational access (Stock, Sales, Expenses) but restricted from sensitive owner data.
3. **Seller**: Restricted to POS and their own sales data.
4. **Global Admin**: System-wide access for platform management.

## Authentication Flow
1. **Login**: 
   - User submits email/password.
   - System validates against `localStorage` (mock DB).
   - JWT Token (simulated) returned.
   - User profile loaded with `permissions` array based on role.

2. **Signup**:
   - New users are created as **Owners** of a new business by default.
   - Team members (Managers/Sellers) are created by Owners via Team Management.

3. **Team Member Creation**:
   - Owner creates user.
   - System generates **Temporary Password**.
   - User status set to `inactive`.
   - On first login, user validates temp password and must set permanent password.

## Security Features
- **Bcrypt Simulation**: Passwords are hashed before storage (using simple hashing for frontend prototype).
- **Audit Logging**: Critical actions (login, delete, update) are logged.
- **Role-Based Access Control (RBAC)**: `ProtectedRoute` ensures users only access allowed routes.
- **Business Isolation**: All data queries are scoped by `business_id`.

## Extension
To add new roles:
1. Update `src/lib/roles.js`.
2. Define permissions in `src/lib/permissions.js`.
3. Update `ProtectedRoute` usage in `src/App.jsx`.
