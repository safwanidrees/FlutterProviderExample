import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Provider/auth.dart';
import 'package:shop/Provider/cart.dart';
import 'package:shop/screens/product_detail_screen.dart';
import '../Provider/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  //  var _edittedProduct = CartItem(
  //   id: null,
  //   title: '',
  //   price: 0,
  //   quantity:0
   
  // );
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    final auth=Provider.of<Auth>(context);
    //it can get data from product class

//we alsos use consumer instead of provider

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.routeName, arguments: data.id);
          },
          child: Image.network(
            data.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetailScreen.routeName, arguments: data.id);
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (ctx) => ProductDetailScreen(title)));
            },
            child: Text(data.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.body1),
          ),
          backgroundColor: Colors.black,
          leading: Consumer<Product>(
            builder: (ctx, datas, child) => IconButton(
              onPressed: () {
                datas.istoggleFavorite(auth.token,auth.userId);
              },
              icon: Icon(
                datas.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.orange,
              ),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.orange,
            ),
            onPressed: () {
              cart.addItem(data.id, data.price, data.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added Item to Cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                     label: 'UNDO',
                    onPressed: () {
                     
                      
                      cart.undo(data.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
