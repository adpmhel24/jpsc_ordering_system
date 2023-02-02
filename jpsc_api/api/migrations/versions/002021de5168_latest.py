"""latest

Revision ID: 002021de5168
Revises: a45367a1f187
Create Date: 2022-10-17 12:48:24.600751

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '002021de5168'
down_revision = 'a45367a1f187'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('sys_auth',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('system_user_id', sa.Integer(), nullable=False),
    sa.Column('objtype', sa.Integer(), nullable=False),
    sa.Column('auth', sqlmodel.sql.sqltypes.AutoString(), nullable=False),
    sa.Column('date_updated', sa.DateTime(), nullable=True),
    sa.Column('updated_by', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['objtype'], ['object_type.id'], ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['system_user_id'], ['system_user.id'], ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['updated_by'], ['system_user.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_sys_auth_auth'), 'sys_auth', ['auth'], unique=False)
    op.create_index(op.f('ix_sys_auth_id'), 'sys_auth', ['id'], unique=False)
    op.create_index(op.f('ix_sys_auth_objtype'), 'sys_auth', ['objtype'], unique=False)
    op.create_index(op.f('ix_sys_auth_system_user_id'), 'sys_auth', ['system_user_id'], unique=False)
    op.drop_index('ix_authorization_auth', table_name='authorization')
    op.drop_index('ix_authorization_id', table_name='authorization')
    op.drop_index('ix_authorization_objtype', table_name='authorization')
    op.drop_index('ix_authorization_system_user_id', table_name='authorization')
    op.drop_table('authorization')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('authorization',
    sa.Column('id', sa.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('system_user_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('objtype', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('auth', sa.VARCHAR(), autoincrement=False, nullable=False),
    sa.Column('date_updated', postgresql.TIMESTAMP(), autoincrement=False, nullable=True),
    sa.Column('updated_by', sa.INTEGER(), autoincrement=False, nullable=True),
    sa.ForeignKeyConstraint(['objtype'], ['object_type.id'], name='authorization_objtype_fkey', ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['system_user_id'], ['system_user.id'], name='authorization_system_user_id_fkey', ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['updated_by'], ['system_user.id'], name='authorization_updated_by_fkey'),
    sa.PrimaryKeyConstraint('id', name='authorization_pkey')
    )
    op.create_index('ix_authorization_system_user_id', 'authorization', ['system_user_id'], unique=False)
    op.create_index('ix_authorization_objtype', 'authorization', ['objtype'], unique=False)
    op.create_index('ix_authorization_id', 'authorization', ['id'], unique=False)
    op.create_index('ix_authorization_auth', 'authorization', ['auth'], unique=False)
    op.drop_index(op.f('ix_sys_auth_system_user_id'), table_name='sys_auth')
    op.drop_index(op.f('ix_sys_auth_objtype'), table_name='sys_auth')
    op.drop_index(op.f('ix_sys_auth_id'), table_name='sys_auth')
    op.drop_index(op.f('ix_sys_auth_auth'), table_name='sys_auth')
    op.drop_table('sys_auth')
    # ### end Alembic commands ###
