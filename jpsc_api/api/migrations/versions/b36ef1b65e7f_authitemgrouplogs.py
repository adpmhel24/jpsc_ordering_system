"""authItemGroupLogs

Revision ID: b36ef1b65e7f
Revises: 7d52c5f163e3
Create Date: 2022-11-07 15:33:42.253180

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel  # new


# revision identifiers, used by Alembic.
revision = "b36ef1b65e7f"
down_revision = "7d52c5f163e3"
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table(
        "logs_auth_item_group",
        sa.Column("log_id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("item_group_auth_id", sa.Integer(), nullable=False),
        sa.Column("system_user_id", sa.Integer(), nullable=False),
        sa.Column(
            "item_group_code", sqlmodel.sql.sqltypes.AutoString(), nullable=False
        ),
        sa.Column(
            "grant_last_purc",
            sa.Boolean(),
            server_default=sa.text("false"),
            nullable=False,
        ),
        sa.Column(
            "grant_avg_value",
            sa.Boolean(),
            server_default=sa.text("false"),
            nullable=False,
        ),
        sa.Column("date_updated", sa.DateTime(), nullable=True),
        sa.Column("updated_by", sa.Integer(), nullable=True),
        sa.ForeignKeyConstraint(
            ["item_group_auth_id"], ["auth_item_group.id"], ondelete="RESTRICT"
        ),
        sa.ForeignKeyConstraint(
            ["item_group_code"], ["item_group.code"], onupdate="CASCADE"
        ),
        sa.ForeignKeyConstraint(
            ["system_user_id"], ["system_user.id"], ondelete="CASCADE"
        ),
        sa.ForeignKeyConstraint(
            ["updated_by"],
            ["system_user.id"],
        ),
        sa.PrimaryKeyConstraint("log_id"),
    )
    op.create_index(
        op.f("ix_logs_auth_item_group_item_group_auth_id"),
        "logs_auth_item_group",
        ["item_group_auth_id"],
        unique=False,
    )
    op.create_index(
        op.f("ix_logs_auth_item_group_item_group_code"),
        "logs_auth_item_group",
        ["item_group_code"],
        unique=False,
    )
    op.create_index(
        op.f("ix_logs_auth_item_group_log_id"),
        "logs_auth_item_group",
        ["log_id"],
        unique=True,
    )
    op.create_index(
        op.f("ix_logs_auth_item_group_system_user_id"),
        "logs_auth_item_group",
        ["system_user_id"],
        unique=False,
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(
        op.f("ix_logs_auth_item_group_system_user_id"),
        table_name="logs_auth_item_group",
    )
    op.drop_index(
        op.f("ix_logs_auth_item_group_log_id"), table_name="logs_auth_item_group"
    )
    op.drop_index(
        op.f("ix_logs_auth_item_group_item_group_code"),
        table_name="logs_auth_item_group",
    )
    op.drop_index(
        op.f("ix_logs_auth_item_group_item_group_auth_id"),
        table_name="logs_auth_item_group",
    )
    op.drop_table("logs_auth_item_group")
    # ### end Alembic commands ###