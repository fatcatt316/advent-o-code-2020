"Passport Validator"

Eval [
  "Read the input file line-by-line."

  valid_passport_count := 0.

  "Expected values"
  expected_values := Array new: 7.
  expected_values at: 1 put: 1.
  expected_values at: 2 put: 1.
  expected_values at: 3 put: 1.
  expected_values at: 4 put: 1.
  expected_values at: 5 put: 1.
  expected_values at: 6 put: 1.
  expected_values at: 7 put: 1.

  "Set the required fields"
  required_fields := Dictionary new.
  required_fields at: 'byr' put: nil.
  required_fields at: 'iyr' put: nil.
  required_fields at: 'eyr' put: nil.
  required_fields at: 'hgt' put: nil.
  required_fields at: 'hcl' put: nil.
  required_fields at: 'ecl' put: nil.
  required_fields at: 'pid' put: nil.

  inputFile := FileStream open: 'input.txt' mode: FileStream read.
  inputFile linesDo: [:line |
    (line) displayNl.
    line_chunks := line substrings.
    chunk_count := line_chunks size.
    1 to: chunk_count do: [:i |
      line_chunk := line_chunks at: i.
      field := (line_chunk substrings: ':') at: 1.

      "Ignore if the field is 'cid'"
      field = 'cid'
        ifFalse: [
          required_fields at: field put: 1.
        ]
    ].

    reset_required_fields := False.

    required_fields values = expected_values
      ifTrue: [
        '⭐Valid passport⭐' displayNl.

        valid_passport_count := valid_passport_count + 1.
        reset_required_fields := True.
      ].

    "If on a blank line, reset the required_fields"
    chunk_count = 0
      ifTrue: [
        reset_required_fields := True
      ].

    reset_required_fields = True
      ifTrue: [
        required_fields := Dictionary new.
        required_fields at: 'byr' put: nil.
        required_fields at: 'iyr' put: nil.
        required_fields at: 'eyr' put: nil.
        required_fields at: 'hgt' put: nil.
        required_fields at: 'hcl' put: nil.
        required_fields at: 'ecl' put: nil.
        required_fields at: 'pid' put: nil.
      ]
  ].
  inputFile close.

  '' displayNl.
  'Valid passport count: ' displayNl.
  (valid_passport_count) displayNl.
]