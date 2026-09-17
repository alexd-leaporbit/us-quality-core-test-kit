# US Quality Core requirements

The initial catalog contains only the two identified Patient retrieval requirements
from US Quality Core 1.0.0-ballot. It is not a complete inventory of IG obligations.
The IG narrative is the source of truth; stable statement IDs match those used by
the Publisher-generated requirements index.

From the test kit root, using the repo Ruby and installed dependencies:

```sh
bundle exec ruby scripts/import_requirements.rb ../fhir-us-quality-core
bundle exec rake usqualitycore:generate mode=server
bundle exec inferno requirements coverage us_quality_core_v100_ballot
bundle exec inferno requirements check_coverage us_quality_core_v100_ballot
```

The import accepts an alternate IG checkout path and checks its version and both
statement IDs. It writes `us_quality_core_test_kit_requirements.csv` here.
This catalog is imported from IG Markdown, so do not use Inferno's spreadsheet-based
`requirements export_csv` or `requirements check` commands for it.

The read, search, and suite generator templates declare the mappings and requirement
set. They apply only to the 1.0.0-ballot server suite. Add future mappings to the
templates or generator sources, not directly to generated tests.

`generated/us_quality_core_v100_ballot_requirements_coverage.csv` is produced by
Inferno's coverage command. It records which tests claim coverage, not test outcomes.
Generating or checking this report does not run the tests; the mapped tests can
still skip when suitable Patient data is unavailable.
