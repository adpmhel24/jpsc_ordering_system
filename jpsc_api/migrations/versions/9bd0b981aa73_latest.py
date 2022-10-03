"""latest

Revision ID: 9bd0b981aa73
Revises: 7e38639c59b0
Create Date: 2022-09-13 03:23:02.906918

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = '9bd0b981aa73'
down_revision = '7e38639c59b0'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('alt_uom_id_key', 'alt_uom', type_='unique')
    op.create_index(op.f('ix_alt_uom_id'), 'alt_uom', ['id'], unique=False)
    op.drop_constraint('customer_address_id_key', 'customer_address', type_='unique')
    op.create_index(op.f('ix_customer_address_id'), 'customer_address', ['id'], unique=False)
    op.drop_constraint('inv_adj_in_h_id_key', 'inv_adj_in_h', type_='unique')
    op.create_index(op.f('ix_inv_adj_in_h_id'), 'inv_adj_in_h', ['id'], unique=False)
    op.drop_constraint('inv_adj_in_r_id_key', 'inv_adj_in_r', type_='unique')
    op.create_index(op.f('ix_inv_adj_in_r_id'), 'inv_adj_in_r', ['id'], unique=False)
    op.drop_constraint('inv_adj_out_h_id_key', 'inv_adj_out_h', type_='unique')
    op.create_index(op.f('ix_inv_adj_out_h_id'), 'inv_adj_out_h', ['id'], unique=False)
    op.drop_constraint('inv_adj_out_r_id_key', 'inv_adj_out_r', type_='unique')
    op.create_index(op.f('ix_inv_adj_out_r_id'), 'inv_adj_out_r', ['id'], unique=False)
    op.drop_constraint('inv_receive_h_id_key', 'inv_receive_h', type_='unique')
    op.create_index(op.f('ix_inv_receive_h_id'), 'inv_receive_h', ['id'], unique=False)
    op.drop_constraint('inv_receive_r_id_key', 'inv_receive_r', type_='unique')
    op.create_index(op.f('ix_inv_receive_r_id'), 'inv_receive_r', ['id'], unique=False)
    op.drop_constraint('inv_transaction_id_key', 'inv_transaction', type_='unique')
    op.create_index(op.f('ix_inv_transaction_id'), 'inv_transaction', ['id'], unique=False)
    op.drop_constraint('inv_trfr_h_id_key', 'inv_trfr_h', type_='unique')
    op.create_index(op.f('ix_inv_trfr_h_id'), 'inv_trfr_h', ['id'], unique=False)
    op.drop_constraint('inv_trfr_r_id_key', 'inv_trfr_r', type_='unique')
    op.create_index(op.f('ix_inv_trfr_r_id'), 'inv_trfr_r', ['id'], unique=False)
    op.drop_constraint('inv_trfr_req_h_id_key', 'inv_trfr_req_h', type_='unique')
    op.create_index(op.f('ix_inv_trfr_req_h_id'), 'inv_trfr_req_h', ['id'], unique=False)
    op.drop_constraint('inv_trfr_req_r_id_key', 'inv_trfr_req_r', type_='unique')
    op.create_index(op.f('ix_inv_trfr_req_r_id'), 'inv_trfr_req_r', ['id'], unique=False)
    op.drop_constraint('system_user_id_key', 'system_user', type_='unique')
    op.create_index(op.f('ix_system_user_id'), 'system_user', ['id'], unique=False)
    op.drop_constraint('whseinv_id_key', 'whseinv', type_='unique')
    op.create_index(op.f('ix_whseinv_id'), 'whseinv', ['id'], unique=False)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_whseinv_id'), table_name='whseinv')
    op.create_unique_constraint('whseinv_id_key', 'whseinv', ['id'])
    op.drop_index(op.f('ix_system_user_id'), table_name='system_user')
    op.create_unique_constraint('system_user_id_key', 'system_user', ['id'])
    op.drop_index(op.f('ix_inv_trfr_req_r_id'), table_name='inv_trfr_req_r')
    op.create_unique_constraint('inv_trfr_req_r_id_key', 'inv_trfr_req_r', ['id'])
    op.drop_index(op.f('ix_inv_trfr_req_h_id'), table_name='inv_trfr_req_h')
    op.create_unique_constraint('inv_trfr_req_h_id_key', 'inv_trfr_req_h', ['id'])
    op.drop_index(op.f('ix_inv_trfr_r_id'), table_name='inv_trfr_r')
    op.create_unique_constraint('inv_trfr_r_id_key', 'inv_trfr_r', ['id'])
    op.drop_index(op.f('ix_inv_trfr_h_id'), table_name='inv_trfr_h')
    op.create_unique_constraint('inv_trfr_h_id_key', 'inv_trfr_h', ['id'])
    op.drop_index(op.f('ix_inv_transaction_id'), table_name='inv_transaction')
    op.create_unique_constraint('inv_transaction_id_key', 'inv_transaction', ['id'])
    op.drop_index(op.f('ix_inv_receive_r_id'), table_name='inv_receive_r')
    op.create_unique_constraint('inv_receive_r_id_key', 'inv_receive_r', ['id'])
    op.drop_index(op.f('ix_inv_receive_h_id'), table_name='inv_receive_h')
    op.create_unique_constraint('inv_receive_h_id_key', 'inv_receive_h', ['id'])
    op.drop_index(op.f('ix_inv_adj_out_r_id'), table_name='inv_adj_out_r')
    op.create_unique_constraint('inv_adj_out_r_id_key', 'inv_adj_out_r', ['id'])
    op.drop_index(op.f('ix_inv_adj_out_h_id'), table_name='inv_adj_out_h')
    op.create_unique_constraint('inv_adj_out_h_id_key', 'inv_adj_out_h', ['id'])
    op.drop_index(op.f('ix_inv_adj_in_r_id'), table_name='inv_adj_in_r')
    op.create_unique_constraint('inv_adj_in_r_id_key', 'inv_adj_in_r', ['id'])
    op.drop_index(op.f('ix_inv_adj_in_h_id'), table_name='inv_adj_in_h')
    op.create_unique_constraint('inv_adj_in_h_id_key', 'inv_adj_in_h', ['id'])
    op.drop_index(op.f('ix_customer_address_id'), table_name='customer_address')
    op.create_unique_constraint('customer_address_id_key', 'customer_address', ['id'])
    op.drop_index(op.f('ix_alt_uom_id'), table_name='alt_uom')
    op.create_unique_constraint('alt_uom_id_key', 'alt_uom', ['id'])
    # ### end Alembic commands ###
