# ExtendedRatio Runtime Parity

**Audience:** researchers, contributors, verification-oriented developers  
**Status:** canonical parity map

This page maps the runtime `ExtendedRatio` behavior to the Lean theorem surface
and regression tests that protect the behavior.

## Scope

This map covers semantic rules that are both:

1. implemented in the Python runtime, and
2. represented by a public Lean theorem in `ACT.ExtendedRatio`.

Runtime details not listed here are not yet claimed as formally synchronized.

## Parity Table

| Runtime rule | Python surface | Lean theorem | Regression test |
|---|---|---|---|
| finite division with non-zero denominator stays finite | `ExtendedRatio.from_division` | `ACT.ExtendedRatio.fromDivision_of_den_nonzero` | `tests/test_extended_ratio.py::test_extended_ratio_finite_from_division` |
| `0 / 0` becomes `indeterminate` | `ExtendedRatio.from_division` | `ACT.ExtendedRatio.fromDivision_zero_zero` | `tests/test_extended_ratio.py::test_extended_ratio_indeterminate_for_absolute_over_absolute` |
| non-zero over zero becomes signed infinity | `ExtendedRatio.from_division` | `ACT.ExtendedRatio.fromDivision_of_num_nonzero_den_zero` | `tests/test_extended_ratio.py::test_extended_ratio_positive_infinity_from_absolute_denominator` |
| `indeterminate + x` stays `indeterminate` | `ExtendedRatio.__add__` | `ACT.ExtendedRatio.add_indeterminate_left` | `tests/test_extended_ratio_semantic_parity.py::test_add_indeterminate_left_matches_lean_theorem` |
| `x + indeterminate` stays `indeterminate` | `ExtendedRatio.__add__` | `ACT.ExtendedRatio.add_indeterminate_right` | `tests/test_extended_ratio_semantic_parity.py::test_add_indeterminate_right_matches_lean_theorem` |
| `indeterminate * x` stays `indeterminate` | `ExtendedRatio.__mul__` | `ACT.ExtendedRatio.mul_indeterminate_left` | `tests/test_extended_ratio_semantic_parity.py::test_mul_indeterminate_left_matches_lean_theorem` |
| `x * indeterminate` stays `indeterminate` | `ExtendedRatio.__mul__` | `ACT.ExtendedRatio.mul_indeterminate_right` | `tests/test_extended_ratio_semantic_parity.py::test_mul_indeterminate_right_matches_lean_theorem` |
| opposite infinities add to `indeterminate` | `ExtendedRatio.__add__` | `ACT.ExtendedRatio.add_opposite_infinities_indeterminate` | `tests/test_extended_ratio_semantic_parity.py::test_add_opposite_infinities_matches_lean_theorem` |
| same infinities preserve infinity | `ExtendedRatio.__add__` | `ACT.ExtendedRatio.add_same_infinities` | `tests/test_extended_ratio_semantic_parity.py::test_add_same_positive_infinities_matches_lean_theorem`, `tests/test_extended_ratio_semantic_parity.py::test_add_same_negative_infinities_matches_lean_theorem` |
| `0 * infinity` becomes `indeterminate` | `ExtendedRatio.__mul__` | `ACT.ExtendedRatio.mul_finite_zero_infinite_indeterminate` | `tests/test_extended_ratio_semantic_parity.py::test_zero_times_infinity_matches_lean_theorem` |
| `infinity * 0` becomes `indeterminate` | `ExtendedRatio.__mul__` | `ACT.ExtendedRatio.mul_infinite_finite_zero_indeterminate` | `tests/test_extended_ratio_semantic_parity.py::test_zero_times_infinity_matches_lean_theorem` |
| saturating infinity produces bounded finite output | `ExtendedRatio.saturate` | `ACT.ExtendedRatio.saturate_infinite` | `tests/test_extended_ratio_semantic_parity.py::test_saturate_infinite_matches_lean_boundary` |
| saturating finite value leaves it unchanged | `ExtendedRatio.saturate` | `ACT.ExtendedRatio.saturate_finite` | `tests/test_extended_ratio_semantic_parity.py::test_saturate_finite_matches_lean_boundary` |
| saturating `indeterminate` leaves it explicit | `ExtendedRatio.saturate` | `ACT.ExtendedRatio.saturate_indeterminate` | `tests/test_extended_ratio_semantic_parity.py::test_saturate_indeterminate_matches_lean_boundary` |
| `raise` accepts finite values | `ExtendedRatio.apply_policy` | `ACT.ExtendedRatio.applyPolicy_raise_finite` | `tests/test_extended_ratio_semantic_parity.py::test_apply_policy_raise_finite_matches_lean_theorem` |
| `raise` rejects infinity | `ExtendedRatio.apply_policy` | `ACT.ExtendedRatio.applyPolicy_raise_infinite` | `tests/test_extended_ratio_semantic_parity.py::test_apply_policy_raise_infinite_matches_lean_theorem` |
| `raise` rejects `indeterminate` | `ExtendedRatio.apply_policy` | `ACT.ExtendedRatio.applyPolicy_raise_indeterminate` | `tests/test_extended_ratio_semantic_parity.py::test_apply_policy_raise_indeterminate_matches_lean_theorem` |
| `propagate` preserves state | `ExtendedRatio.apply_policy` | `ACT.ExtendedRatio.applyPolicy_propagate` | `tests/test_extended_ratio_semantic_parity.py::test_apply_policy_propagate_matches_lean_theorem` |
| `saturate` applies saturation boundary | `ExtendedRatio.apply_policy` | `ACT.ExtendedRatio.applyPolicy_saturate` | `tests/test_extended_ratio_semantic_parity.py::test_apply_policy_saturate_matches_lean_theorem` |

## Non-Claims

This parity map does not yet claim theorem coverage for:

- every finite arithmetic identity inherited from `EternalRatio`
- sign-sensitive finite-times-infinity multiplication beyond the zero case
- division of arbitrary `ExtendedRatio` values
- metric or topological laws for singular states

Those remain separate formalization targets.

## Verification Commands

```bash
pytest tests/test_extended_ratio.py tests/test_extended_ratio_semantic_parity.py --no-cov
cd formal
lake build
lake env lean FormalAudit.lean
```

## Related Docs

- [Proof Map](proof-map.md)
- [ExtendedRatio Formalization Outline](extended-ratio-outline.md)
- [ExtendedRatio API](../api/core/extended-ratio.md)
