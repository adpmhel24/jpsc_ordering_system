"""latest

Revision ID: d38df1bfe03d
Revises: 5290d1d412ec
Create Date: 2022-09-18 04:30:57.671494

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = 'd38df1bfe03d'
down_revision = '5290d1d412ec'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('pricelist_r', sa.Column('uom', sqlmodel.sql.sqltypes.AutoString(), nullable=True))
    op.create_foreign_key(None, 'pricelist_r', 'uom', ['uom'], ['code'], onupdate='CASCADE')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'pricelist_r', type_='foreignkey')
    op.drop_column('pricelist_r', 'uom')
    # ### end Alembic commands ###
