from postcode_uk.services import is_postcode_uk


def test_should_check_postcode_is_validate():
    # GIVEN
    postcode = "EC1A 1BB"

    # WHEN
    result = is_postcode_uk(postcode)

    # THEN
    assert result is True


def test_should_not_check_postcode_is_validate_due_postcode_outline():
    # GIVEN
    postcode = "ECAA 1BB"

    # WHEN
    result = is_postcode_uk(postcode)

    # THEN
    assert result is False
