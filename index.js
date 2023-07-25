function elevateStock(obj)
{
    obj.style.height = '60px';
}

function de_elevateStock(obj)
{
    obj.style.height = '50px';
}

function clicked(obj)
{
    var stock = obj.innerHTML;
    window.alert('fetching '+ stock + ' stock information from Yahoo');
}