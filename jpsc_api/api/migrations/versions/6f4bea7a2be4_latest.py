"""latest

Revision ID: 6f4bea7a2be4
Revises: aea247dfff43
Create Date: 2022-09-15 02:00:09.145787

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = '6f4bea7a2be4'
down_revision = 'aea247dfff43'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('sales_order_attachment', 'comment')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('sales_order_attachment', sa.Column('comment', sa.VARCHAR(), autoincrement=False, nullable=False))
    # ### end Alembic commands ###