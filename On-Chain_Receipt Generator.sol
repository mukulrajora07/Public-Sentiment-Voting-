<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>On-Chain Receipt Generator</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f0f0f0;
        }
        .container {
            max-width: 1200px;
            margin-top: 50px;
        }
        .receipt-card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">On-Chain Receipt Generator</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">On-Chain Receipt Generator</h1>
                <p class="text-center">A platform for generating receipts for on-chain transactions.</p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <h2>Generate Receipt</h2>
                <form id="receipt-form">
                    <div class="form-group">
                        <label for="transaction-id">Transaction ID:</label>
                        <input type="text" class="form-control" id="transaction-id" required>
                    </div>
                    <div class="form-group">
                        <label for="transaction-date">Transaction Date:</label>
                        <input type="date" class="form-control" id="transaction-date" required>
                    </div>
                    <div class="form-group">
                        <label for="amount">Amount:</label>
                        <input type="number" class="form-control" id="amount" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Generate Receipt</button>
                </form>
            </div>
            <div class="col-md-6">
                <h2>Receipts</h2>
                <div id="receipts" class="receipts"></div>
            </div>
        </div>
        <div class="modal fade" id="receipt-modal" tabindex="-1" role="dialog" aria-labelledby="receipt-modal-label" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="receipt-modal-label">Receipt Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="receipt-details"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Generate receipt
            $('#receipt-form').submit(function(e) {
                e.preventDefault();
                var transactionId = $('#transaction-id').val();
                var transactionDate = $('#transaction-date').val();
                var amount = $('#amount').val();
                var receipt = {
                    transactionId: transactionId,
                    transactionDate: transactionDate,
                    amount: amount
                };
                localStorage.setItem('receipt-' + transactionId, JSON.stringify(receipt));
                displayReceipts();
            });

            // Display receipts
            function displayReceipts() {
                var receipts = '';
                for (var i = 0; i < localStorage.length; i++) {
                    var key = localStorage.key(i);
                    if (key.startsWith('receipt-')) {
                        var receipt = JSON.parse(localStorage.getItem(key));
                        receipts += '<div class="card receipt-card">' +
                            '<div class="card-body">' +
                            '<h5 class="card-title">Transaction ID: ' + receipt.transactionId + '</h5>' +
                            '<p class="card-text">Transaction Date: ' + receipt.transactionDate + '</p>' +
                            '<p class="card-text">Amount: ' + receipt.amount + '</p>' +
                            '<button class="btn btn-primary" onclick="showReceiptDetails(\'' + key + '\')">Details</button>' +
                            '</div>' +
                            '</div>';
                    }
                }
                $('#receipts').html(receipts);
            }

            // Show receipt details
            function showReceiptDetails(key) {
                var receipt = JSON.parse(localStorage.getItem(key));
                $('#receipt-details').html('Transaction ID: ' + receipt.transactionId + '<br>Transaction Date: ' + receipt.transactionDate + '<br>Amount: ' + receipt.amount);
                $('#receipt-modal').modal('show');
            }

            // Initialize display receipts
            displayReceipts();
        });
    </script>
</body>
</html>
