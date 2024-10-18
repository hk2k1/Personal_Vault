-- Create extension for UUID support
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create enum type for Platform
CREATE TYPE platform_type AS ENUM ('Operational', 'Offline', 'Spare');

-- Create tables
CREATE TABLE Role (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    permissions TEXT,
    created_by UUID,
    updated_by UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE User (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role_id UUID REFERENCES Role(id),
    department VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Platform (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    type platform_type NOT NULL,
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ServerType (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Location (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    address TEXT,
    city VARCHAR(255),
    country VARCHAR(255),
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Host (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    hostname VARCHAR(255) NOT NULL UNIQUE,
    hardware_model VARCHAR(255),
    server_type_id UUID REFERENCES ServerType(id),
    bios_version VARCHAR(255),
    asset_tag VARCHAR(255),
    purchase_date DATE,
    purchase_cost DECIMAL(10, 2),
    location_id UUID REFERENCES Location(id),
    platform_id UUID REFERENCES Platform(id),
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DeploymentRecord (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    deployment_date DATE NOT NULL,
    host_id UUID REFERENCES Host(id),
    user_id UUID REFERENCES User(id),
    notes TEXT,
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Software (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    vendor VARCHAR(255),
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE SoftwareDeployment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    deployment_record_id UUID REFERENCES DeploymentRecord(id),
    software_id UUID REFERENCES Software(id),
    version VARCHAR(255) NOT NULL,
    is_update BOOLEAN DEFAULT FALSE,
    update_notes TEXT,
    previous_version_id UUID REFERENCES SoftwareDeployment(id),
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LicenseInfo (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    software_deployment_id UUID REFERENCES SoftwareDeployment(id),
    license_key VARCHAR(255),
    expiration_date DATE,
    seat_count INTEGER,
    cost DECIMAL(10, 2),
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MaintenanceRecord (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID REFERENCES Host(id),
    maintenance_date DATE NOT NULL,
    description TEXT,
    performed_by_user_id UUID REFERENCES User(id),
    created_by UUID REFERENCES User(id),
    updated_by UUID REFERENCES User(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AuditLog (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES User(id),
    action VARCHAR(255) NOT NULL,
    entity_type VARCHAR(255) NOT NULL,
    entity_id UUID NOT NULL,
    changes JSONB,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Add foreign key constraints for created_by and updated_by
ALTER TABLE Role
ADD CONSTRAINT fk_role_created_by FOREIGN KEY (created_by) REFERENCES User(id),
ADD CONSTRAINT fk_role_updated_by FOREIGN KEY (updated_by) REFERENCES User(id);

-- Create indexes
CREATE INDEX idx_host_hostname ON Host(hostname);
CREATE INDEX idx_software_deployment_is_update ON SoftwareDeployment(is_update);
CREATE INDEX idx_audit_log_timestamp ON AuditLog(timestamp);
CREATE INDEX idx_audit_log_user_id ON AuditLog(user_id);
CREATE INDEX idx_audit_log_entity_type_id ON AuditLog(entity_type, entity_id);