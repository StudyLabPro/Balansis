import pytest

from balansis import ExtendedRatio, SingularPolicy


@pytest.mark.parametrize(
    "value",
    [
        ExtendedRatio.from_float(1.0),
        ExtendedRatio.positive_infinity(),
        ExtendedRatio.negative_infinity(),
        ExtendedRatio.indeterminate(),
    ],
)
def test_add_indeterminate_left_matches_lean_theorem(value):
    result = ExtendedRatio.indeterminate() + value
    assert result.is_indeterminate()


@pytest.mark.parametrize(
    "value",
    [
        ExtendedRatio.from_float(1.0),
        ExtendedRatio.positive_infinity(),
        ExtendedRatio.negative_infinity(),
        ExtendedRatio.indeterminate(),
    ],
)
def test_add_indeterminate_right_matches_lean_theorem(value):
    result = value + ExtendedRatio.indeterminate()
    assert result.is_indeterminate()


@pytest.mark.parametrize(
    "value",
    [
        ExtendedRatio.from_float(1.0),
        ExtendedRatio.positive_infinity(),
        ExtendedRatio.negative_infinity(),
        ExtendedRatio.indeterminate(),
    ],
)
def test_mul_indeterminate_left_matches_lean_theorem(value):
    result = ExtendedRatio.indeterminate() * value
    assert result.is_indeterminate()


@pytest.mark.parametrize(
    "value",
    [
        ExtendedRatio.from_float(1.0),
        ExtendedRatio.positive_infinity(),
        ExtendedRatio.negative_infinity(),
        ExtendedRatio.indeterminate(),
    ],
)
def test_mul_indeterminate_right_matches_lean_theorem(value):
    result = value * ExtendedRatio.indeterminate()
    assert result.is_indeterminate()


def test_add_opposite_infinities_matches_lean_theorem():
    result = ExtendedRatio.positive_infinity() + ExtendedRatio.negative_infinity()
    assert result.is_indeterminate()


def test_add_same_positive_infinities_matches_lean_theorem():
    result = ExtendedRatio.positive_infinity() + ExtendedRatio.positive_infinity()
    assert result.is_infinite()
    assert result.direction == 1


def test_add_same_negative_infinities_matches_lean_theorem():
    result = ExtendedRatio.negative_infinity() + ExtendedRatio.negative_infinity()
    assert result.is_infinite()
    assert result.direction == -1


@pytest.mark.parametrize(
    "infinity",
    [ExtendedRatio.positive_infinity(), ExtendedRatio.negative_infinity()],
)
def test_zero_times_infinity_matches_lean_theorem(infinity):
    zero = ExtendedRatio.from_float(0.0)
    assert (zero * infinity).is_indeterminate()
    assert (infinity * zero).is_indeterminate()


def test_saturate_infinite_matches_lean_boundary():
    result = ExtendedRatio.negative_infinity().saturate(limit=7.0)
    assert result.is_finite()
    assert result.numerical_value() == -7.0


def test_saturate_finite_matches_lean_boundary():
    value = ExtendedRatio.from_float(3.0)
    assert value.saturate(limit=7.0) == value


def test_saturate_indeterminate_matches_lean_boundary():
    value = ExtendedRatio.indeterminate()
    assert value.saturate(limit=7.0) == value


def test_apply_policy_raise_finite_matches_lean_theorem():
    value = ExtendedRatio.from_float(3.0)
    resolved, event = value.apply_policy(SingularPolicy.RAISE)
    assert resolved == value
    assert event is None


def test_apply_policy_raise_infinite_matches_lean_theorem():
    with pytest.raises(ValueError, match="singular ExtendedRatio"):
        ExtendedRatio.positive_infinity().apply_policy(SingularPolicy.RAISE)


def test_apply_policy_raise_indeterminate_matches_lean_theorem():
    with pytest.raises(ValueError, match="singular ExtendedRatio"):
        ExtendedRatio.indeterminate().apply_policy(SingularPolicy.RAISE)


def test_apply_policy_propagate_matches_lean_theorem():
    value = ExtendedRatio.positive_infinity()
    resolved, event = value.apply_policy(SingularPolicy.PROPAGATE)
    assert resolved == value
    assert event is not None
    assert event.policy == SingularPolicy.PROPAGATE


def test_apply_policy_saturate_matches_lean_theorem():
    value = ExtendedRatio.positive_infinity()
    resolved, event = value.apply_policy(SingularPolicy.SATURATE, saturation_limit=5.0)
    assert resolved.is_finite()
    assert resolved.numerical_value() == 5.0
    assert event is not None
    assert event.policy == SingularPolicy.SATURATE
    assert event.saturated
