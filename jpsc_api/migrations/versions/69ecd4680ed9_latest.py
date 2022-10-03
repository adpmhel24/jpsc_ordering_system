"""latest

Revision ID: 69ecd4680ed9
Revises: d38df1bfe03d
Create Date: 2022-09-18 04:33:10.978177

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = '69ecd4680ed9'
down_revision = 'd38df1bfe03d'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('pricelist_r', sa.Column('uom_code', sqlmodel.sql.sqltypes.AutoString(), nullable=True))
    op.drop_constraint('pricelist_r_uom_fkey', 'pricelist_r', type_='foreignkey')
    op.create_foreign_key(None, 'pricelist_r', 'uom', ['uom_code'], ['code'], onupdate='CASCADE')
    op.drop_column('pricelist_r', 'uom')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('pricelist_r', sa.Column('uom', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.drop_constraint(None, 'pricelist_r', type_='foreignkey')
    op.create_foreign_key('pricelist_r_uom_fkey', 'pricelist_r', 'uom', ['uom'], ['code'], onupdate='CASCADE')
    op.drop_column('pricelist_r', 'uom_code')
    # ### end Alembic commands ###
