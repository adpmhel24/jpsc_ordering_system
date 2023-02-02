"""pricelist

Revision ID: a49bb24a485a
Revises: 2604e0e70def
Create Date: 2022-09-14 08:09:02.079357

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = 'a49bb24a485a'
down_revision = '2604e0e70def'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('pricelist_h', sa.Column('is_active', sa.Boolean(), server_default=sa.text('true'), nullable=False))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('pricelist_h', 'is_active')
    # ### end Alembic commands ###
