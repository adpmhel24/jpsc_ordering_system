import os
import sys


def run(args):
    if args[1].lower() == "migrate":
        if args[2].lower():
            cmd = f'alembic revision --autogenerate -m "{args[2]}"'
        else:
            print("Missing message!")
            return 1

    elif args[1].lower() == "upgrade":
        cmd = "alembic upgrade head"
    else:
        print("Unknown error")
        return 1
    os.system(cmd)


if __name__ == "__main__":
    run(sys.argv)
