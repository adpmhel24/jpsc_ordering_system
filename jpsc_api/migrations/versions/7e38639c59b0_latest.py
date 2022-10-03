"""latest

Revision ID: 7e38639c59b0
Revises: 70973f0d6087
Create Date: 2022-09-13 03:22:18.665904

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = '7e38639c59b0'
down_revision = '70973f0d6087'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('system_user', sa.Column('is_active', sa.BOOLEAN(), server_default=sa.text('true'), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('system_user', 'is_active')
    # ### end Alembic commands ###
