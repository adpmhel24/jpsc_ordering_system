"""pricelist

Revision ID: b681e66703eb
Revises: f33291b8b63e
Create Date: 2022-09-14 06:56:19.587144

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = 'b681e66703eb'
down_revision = 'f33291b8b63e'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_index(op.f('ix_pricelist_r_item_code'), 'pricelist_r', ['item_code'], unique=False)
    op.create_index(op.f('ix_pricelist_r_pricelist_code'), 'pricelist_r', ['pricelist_code'], unique=False)
    op.create_foreign_key(None, 'pricelist_r', 'item', ['item_code'], ['code'], onupdate='CASCADE')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'pricelist_r', type_='foreignkey')
    op.drop_index(op.f('ix_pricelist_r_pricelist_code'), table_name='pricelist_r')
    op.drop_index(op.f('ix_pricelist_r_item_code'), table_name='pricelist_r')
    # ### end Alembic commands ###
