import math

from balansis import AbsoluteValue
from balansis.core.eternity import (
    EternalRatio,
    ExtendedRatio,
    SingularArithmeticEvent,
    SingularPolicy,
)
from balansis.core.operations import Operations
from balansis.logic.compensator import Compensator


def test_extended_ratio_finite_from_division():
    result = ExtendedRatio.from_division(
        AbsoluteValue.from_float(6.0),
        AbsoluteValue.from_float(2.0),
    )

    assert result.is_finite()
    assert result.numerical_value() == 3.0
    assert result.finite_ratio() == EternalRatio.from_values(6.0, 2.0)


def test_extended_ratio_positive_infinity_from_absolute_denominator():
    result = ExtendedRatio.from_division(
        AbsoluteValue.from_float(6.0),
        AbsoluteValue.absolute(),
    )

    assert result.is_infinite()
    assert result.direction == 1
    assert math.isinf(result.numerical_value())
    assert result.numerical_value() > 0


def test_extended_ratio_indeterminate_for_absolute_over_absolute():
    result = ExtendedRatio.from_division(
        AbsoluteValue.absolute(),
        AbsoluteValue.absolute(),
    )

    assert result.is_indeterminate()
    assert math.isnan(result.numerical_value())


def test_extended_ratio_addition_opposite_infinities_is_indeterminate():
    left = ExtendedRatio.positive_infinity()
    right = ExtendedRatio.negative_infinity()

    result = left + right

    assert result.is_indeterminate()


def test_extended_ratio_zero_times_infinity_is_indeterminate():
    zero = ExtendedRatio.from_float(0.0)
    infinity = ExtendedRatio.positive_infinity()

    result = zero * infinity

    assert result.is_indeterminate()


def test_extended_ratio_finite_times_negative_infinity():
    finite = ExtendedRatio.from_float(-2.0)
    infinity = ExtendedRatio.positive_infinity()

    result = finite * infinity

    assert result.is_infinite()
    assert result.direction == -1


def test_operations_compensated_divide_extended_keeps_finite_contract():
    ratio, compensation = Operations.compensated_divide_extended(
        AbsoluteValue.from_float(9.0),
        AbsoluteValue.from_float(3.0),
    )

    assert ratio.is_finite()
    assert ratio.numerical_value() == 3.0
    assert compensation == 1.0


def test_operations_compensated_divide_extended_surfaces_infinity():
    ratio, compensation = Operations.compensated_divide_extended(
        AbsoluteValue.from_float(-9.0),
        AbsoluteValue.absolute(),
    )

    assert ratio.is_infinite()
    assert ratio.direction == -1
    assert compensation > 1.0


def test_operations_compensated_divide_extended_surfaces_indeterminate():
    ratio, compensation = Operations.compensated_divide_extended(
        AbsoluteValue.absolute(),
        AbsoluteValue.absolute(),
    )

    assert ratio.is_indeterminate()
    assert compensation > 1.0


def test_extended_ratio_propagate_policy_emits_event():
    ratio = ExtendedRatio.positive_infinity("finite_over_absolute")

    resolved, event = ratio.apply_policy(
        SingularPolicy.PROPAGATE,
        operation="division_test",
    )

    assert resolved.is_infinite()
    assert isinstance(event, SingularArithmeticEvent)
    assert event.policy == SingularPolicy.PROPAGATE
    assert event.input_kind == "infinite"
    assert event.output_kind == "infinite"


def test_extended_ratio_saturate_policy_bounds_infinity():
    ratio = ExtendedRatio.negative_infinity("finite_over_absolute")

    resolved, event = ratio.apply_policy(
        SingularPolicy.SATURATE,
        operation="division_test",
        saturation_limit=42.0,
    )

    assert resolved.is_finite()
    assert resolved.numerical_value() == -42.0
    assert event is not None
    assert event.saturated is True
    assert event.output_kind == "finite"


def test_extended_ratio_raise_policy_rejects_singular_state():
    ratio = ExtendedRatio.indeterminate("absolute_over_absolute")

    import pytest

    with pytest.raises(ValueError, match="singular ExtendedRatio"):
        ratio.apply_policy(SingularPolicy.RAISE, operation="division_test")


def test_operations_compensated_divide_policy_saturates_infinite_result():
    ratio, compensation, event = Operations.compensated_divide_policy(
        AbsoluteValue.from_float(9.0),
        AbsoluteValue.absolute(),
        SingularPolicy.SATURATE,
        saturation_limit=11.0,
    )

    assert ratio.is_finite()
    assert ratio.numerical_value() == 11.0
    assert compensation > 1.0
    assert event is not None
    assert event.saturated is True


def test_compensator_extended_division_records_singularity():
    compensator = Compensator()

    result = compensator.compensate_division_extended(
        AbsoluteValue.from_float(5.0),
        AbsoluteValue.absolute(),
    )

    assert result.is_infinite()
    assert len(compensator.history) == 1
    assert compensator.history[-1].operation_type == "division_extended"
    assert compensator.history[-1].compensation_type.value == "singularity"
