# Requirements inventory and coverage

All 13 US Quality Core 1.0.0-ballot summary requirements are included. The server
report deliberately includes the Client actor inventory as well; it does not
claim client processing verification. The client suites have no new mappings.
Maintain IDs, wording, conformance verbs, source links, actor applicability, and
reasons for leaving requirements unverified directly in
`us_quality_core_test_kit_requirements.csv`, keeping them aligned with the IG.
Only CONF-2, CONF-3, and CONF-5 have verifies_requirements mappings.

From the repository root, with the repository Ruby:

```sh
bundle exec rake usqualitycore:generate mode=server
bundle exec inferno requirements coverage us_quality_core_v100_ballot
bundle exec inferno requirements check_coverage us_quality_core_v100_ballot
```

Source URLs use the Publisher's `ci-c-CONF-N` anchors. Do not use
spreadsheet-based `requirements export_csv` or `requirements check` for this
manually maintained catalog. Inferno generates the coverage report from the
catalog and test mappings; its actor-based row ordering is preserved.

## Mapped evidence and limits

- CONF-2: Must Support tests with Quality-flagged elements.
- CONF-3: Must Support tests with other support elements. These can also include
  Additional USCDI expectations; they do not establish client processing behavior.
- CONF-5: read and search tests with SHALL expectations. A mapping describes that
  test's contribution, not a guarantee that every required capability is covered.
  Medication is excluded as a standalone generated group; audit all required
  capabilities before using this report as a complete conformance assessment.

Mapped tests sample provided resources and can skip for insufficient data. A
populated test-ID column is traceability, not an execution result or proof of
exhaustive coverage. Unverified requirements have explicit reasons and NA test IDs.
SHOULD remains SHOULD; SHALL NOT remains SHALL NOT. No tests or mappings are added
to the 0.5.0 suite. Keep mappings in generator templates, not generated files.
