"""s_u

Revision ID: aea247dfff43
Revises: a49bb24a485a
Create Date: 2022-09-14 08:41:47.366033

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = 'aea247dfff43'
down_revision = 'a49bb24a485a'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index('ix_system_user_branch_code', table_name='system_user')
    op.drop_constraint('system_user_branch_code_fkey', 'system_user', type_='foreignkey')
    op.drop_column('system_user', 'branch_code')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('system_user', sa.Column('branch_code', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.create_foreign_key('system_user_branch_code_fkey', 'system_user', 'branch', ['branch_code'], ['code'], onupdate='CASCADE')
    op.create_index('ix_system_user_branch_code', 'system_user', ['branch_code'], unique=False)
    # ### end Alembic commands ###