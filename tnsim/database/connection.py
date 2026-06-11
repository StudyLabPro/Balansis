"""Compatibility layer for TNSIM database connection helpers."""

from __future__ import annotations

from typing import Any


async def get_database_connection() -> Any:
    from .repository import get_db_connection

    return await get_db_connection()


async def close_database_connection() -> None:
    from .repository import close_database

    await close_database()


async def initialize_database_connection() -> None:
    from .repository import initialize_database

    await initialize_database()
