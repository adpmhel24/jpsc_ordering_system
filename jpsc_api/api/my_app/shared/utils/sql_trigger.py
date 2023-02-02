import enum
from typing import List, Optional
from sqlalchemy.orm import Session


class TriggerOperation(str, enum.Enum):
    before_insert = "BEFORE INSERT"
    before_update = "BEFORE UPDATE"
    before_delete = "BEFORE DELETE"
    after_insert = "AFTER INSERT"
    after_update = "AFTER UPDATE"
    after_delete = "AFTER DELETE"


class TriggerWithFunction:

    def __init__(self, trigger_name: Optional[str] = "", function_name: Optional[str] = ""):
        """
            initialize trigger and function name
        """
        self.trigger_name = trigger_name
        self.function_name = function_name

    def create_or_update_func(self, raw_query: str):
        """
            This function is to create or update exist trigger function
            raw_query = "BEGIN
                    IF (TG_OP = 'INSERT') THEN
                        UPDATE whseinv
                        SET quantity = whseinv.quantity + new.inv_qty
                        WHERE whseinv.item_code = new.item_code 
                        and whseinv.whsecode = new.whsecode;
                    END IF;
                RETURN NEW;	
                END;"

            return sql_raw_query
        """
        query = f"""
            CREATE FUNCTION {self.function_name}
            RETURNS TRIGGER 
            LANGUAGE PLPGSQL
            AS
            $$
            {raw_query}
            $$
        """
        return query

    def create_or_update_trig(self, trigger_op: str, table_name: str):
        """
            This function is to create or update exist trigger function
            trigger_op = AFTER OR BEFORE INSERT, UPDATE, DELETE

            return sql_raw_query
        """
        query = f"""
            CREATE OR REPLACE TRIGGER {self.trigger_name}
            {trigger_op}
            ON {table_name}
            FOR EACH ROW
            EXECUTE PROCEDURE {self.function_name};
            """
        return query
