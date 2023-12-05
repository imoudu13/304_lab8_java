<html>
<head>
    <title>Enter Payment Information</title>
    <!-- Css files -->
</head>
<body>

<h1>Enter Payment Information</h1>

<form action="processPayment.jsp" method="post">
    <label for="cardNumber">Credit Card Number:</label>
    <input type="text" id="cardNumber" name="cardNumber" required><br>

    <label for="expiryDate">Expiry Date:</label>
    <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YYYY" required><br>

    <label for="cvv">CVV:</label>
    <input type="text" id="cvv" name="cvv" required><br>

    <label for="cardHolderName">Cardholder Name:</label>
    <input type="text" id="cardHolderName" name="cardHolderName" required><br>

    <input type="submit" value="Submit Payment">
</form>

</body>
</html>