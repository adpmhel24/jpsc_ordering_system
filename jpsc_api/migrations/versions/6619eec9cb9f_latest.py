"""latest

Revision ID: 6619eec9cb9f
Revises: 002021de5168
Create Date: 2022-10-18 01:05:25.730426

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel # new


# revision identifiers, used by Alembic.
revision = '6619eec9cb9f'
down_revision = '002021de5168'
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
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_sys_auth_system_user_id'), table_name='sys_auth')
    op.drop_index(op.f('ix_sys_auth_objtype'), table_name='sys_auth')
    op.drop_index(op.f('ix_sys_auth_id'), table_name='sys_auth')
    op.drop_index(op.f('ix_sys_auth_auth'), table_name='sys_auth')
    op.drop_table('sys_auth')
    # ### end Alembic commands ###
