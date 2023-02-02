"""latest

Revision ID: 5649c567a920
Revises: 1f87bfef4ac8
Create Date: 2022-09-17 03:38:17.926828

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = '5649c567a920'
down_revision = '1f87bfef4ac8'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('sales_order_h', sa.Column('customer_code', sqlmodel.sql.sqltypes.AutoString(), nullable=False))
    op.drop_index('ix_sales_order_h_cust_code', table_name='sales_order_h')
    op.create_index(op.f('ix_sales_order_h_customer_code'), 'sales_order_h', ['customer_code'], unique=False)
    op.drop_constraint('sales_order_h_cust_code_fkey', 'sales_order_h', type_='foreignkey')
    op.create_foreign_key(None, 'sales_order_h', 'customer', ['customer_code'], ['code'], onupdate='CASCADE')
    op.drop_column('sales_order_h', 'cust_code')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('sales_order_h', sa.Column('cust_code', sa.VARCHAR(), autoincrement=False, nullable=False))
    op.drop_constraint(None, 'sales_order_h', type_='foreignkey')
    op.create_foreign_key('sales_order_h_cust_code_fkey', 'sales_order_h', 'customer', ['cust_code'], ['code'], onupdate='CASCADE')
    op.drop_index(op.f('ix_sales_order_h_customer_code'), table_name='sales_order_h')
    op.create_index('ix_sales_order_h_cust_code', 'sales_order_h', ['cust_code'], unique=False)
    op.drop_column('sales_order_h', 'customer_code')
    # ### end Alembic commands ###