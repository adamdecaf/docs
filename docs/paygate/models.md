The design of PayGate has certain deliberate choices made. These are made with our teams previous experience and current business requirements.

### Amount

PayGate treats amounts as strings (e.g. `USD 12.55`) with a static currency and the numeric portion internally as an integer. This allows us to transmit values between languages and systems without much worry in floating point conversions.

### Depository

We created a `Depository` object which represents a financial instrument which can be debited and credited from (typically an account). This model is separate from `Originator`, `Receiver`, `Customer` and all other objects, but those often reference a `Depository`.

One reason we have separated the `Depository` is to encrypt account numbers before they're persisted. This helps with compliance and regulations around protecting client data.

A `Depository` also has validation for the routing number checksum which helps to prevent invalid data that can only cause bugs or errors.
