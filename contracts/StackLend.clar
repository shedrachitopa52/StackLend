(define-map loans
  {loan-id: uint}
  {
    borrower: principal,
    lender: (optional principal),
    amount: uint,
    collateral: uint,
    interest-rate: uint, ;; e.g. 5 means 5%
    due-block-height: uint,
    repaid: uint,
    status: (string-ascii 16) ;; "requested", "funded", "repaid", "defaulted"
  }
)

(define-public (request-loan (loan-id uint) (amount uint) (collateral uint) (interest-rate uint) (due-block-height uint))
    (begin
        ;; Lock collateral from borrower
        (try! (stx-transfer? collateral tx-sender (as-contract tx-sender)))
        (map-set loans
          {loan-id: loan-id}
          {
            borrower: tx-sender,
            lender: none,
            amount: amount,
            collateral: collateral,
            interest-rate: interest-rate,
            due-block-height: due-block-height,
            repaid: u0,
            status: "requested"
          }
        )
        (ok loan-id))
)

(define-public (fund-loan (loan-id uint))
  (let ((loan (map-get? loans {loan-id: loan-id})))
    (match loan
      loan-data
        (begin
          (asserts! (is-eq (get status loan-data) "requested") (err "Loan not available"))
          ;; Transfer loan amount from lender to borrower
          (unwrap! (stx-transfer? (get amount loan-data) tx-sender (get borrower loan-data)) (err "Transfer failed"))
          ;; Update loan with lender and status
          (map-set loans {loan-id: loan-id}
            {
              borrower: (get borrower loan-data),
              lender: (some tx-sender),
              amount: (get amount loan-data),
              collateral: (get collateral loan-data),
              interest-rate: (get interest-rate loan-data),
              due-block-height: (get due-block-height loan-data),
              repaid: (get repaid loan-data),
              status: "funded"
            })
          (ok true))
      (err "Loan not found"))))
