"""Backward-compatible cache import for TNSIM."""

from ..core.cache.tnsim_cache import TNSIMCache, cached_operation, get_global_cache

__all__ = ["TNSIMCache", "cached_operation", "get_global_cache"]
