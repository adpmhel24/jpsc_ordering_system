"""latest

Revision ID: ad79cdff1aec
Revises: 9e97452ac26d
Create Date: 2022-11-14 13:37:26.381221

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = 'ad79cdff1aec'
down_revision = '9e97452ac26d'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('app_version', sa.Column('date_created', sa.DateTime(), server_default=sa.text('now()'), nullable=True))
    op.add_column('app_version', sa.Column('created_by', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'app_version', 'system_user', ['created_by'], ['id'])
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'app_version', type_='foreignkey')
    op.drop_column('app_version', 'created_by')
    op.drop_column('app_version', 'date_created')
    # ### end Alembic commands ###
