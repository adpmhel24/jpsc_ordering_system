"""itemGroupuserAuth remove

Revision ID: bf5a313d0dc7
Revises: 23537bb2c824
Create Date: 2022-10-29 13:17:37.229904

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'bf5a313d0dc7'
down_revision = '23537bb2c824'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index('ix_item_group_user_auth_item_group_code', table_name='item_group_user_auth')
    op.drop_index('ix_item_group_user_auth_system_user_id', table_name='item_group_user_auth')
    op.drop_index('ix_item_group_user_auth_updated_by', table_name='item_group_user_auth')
    op.drop_table('item_group_user_auth')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('item_group_user_auth',
    sa.Column('system_user_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('item_group_code', sa.VARCHAR(), autoincrement=False, nullable=False),
    sa.Column('grant_last_purc', sa.BOOLEAN(), server_default=sa.text('false'), autoincrement=False, nullable=False),
    sa.Column('grant_avg_value', sa.BOOLEAN(), server_default=sa.text('false'), autoincrement=False, nullable=False),
    sa.Column('updated_by', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('date_udpated', postgresql.TIMESTAMP(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['system_user_id'], ['system_user.id'], name='item_group_user_auth_system_user_id_fkey', ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('item_group_code', 'updated_by', name='item_group_user_auth_pkey')
    )
    op.create_index('ix_item_group_user_auth_updated_by', 'item_group_user_auth', ['updated_by'], unique=False)
    op.create_index('ix_item_group_user_auth_system_user_id', 'item_group_user_auth', ['system_user_id'], unique=False)
    op.create_index('ix_item_group_user_auth_item_group_code', 'item_group_user_auth', ['item_group_code'], unique=False)
    # ### end Alembic commands ###
