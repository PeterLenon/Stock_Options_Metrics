
function fetchStocks()
{
    var elements = document.getElementsByClassName('stock');
    for(var i = 0; i< elements.length; i++)
    {
        const stockSymbol = elements[i].innerHTML;
        const yahoo = `https://query1.finance.yahoo.com/v7/finance/quote?symbols=${stockSymbol}`;

        fetch(yahoo)
        .then(response => response.json())
        .then(data => {
            const stockInfo = data.quoteResponse.result[0];

            // Access the desired data (example: stock symbol, current price)
            const symbol = stockInfo.symbol;
            const price = stockInfo.regularMarketPrice;

            // Display the stock information
            alert(`Symbol: ${symbol}` `Price: ${price}` )
            // console.log(`Symbol: ${symbol}`);
            // console.log(`Price: ${price}`);
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }

}

fetchStocks();