/// ORIGINAL ETSY REDUCER   ///

import { FETCH_PRODUCTS } from "../actions/index";

const initalState = [
  // {
  //   image_url: null,
  //   description: null,
  //   // ...
  // }
];

export default function(state = initalState, action) {
  // Dont mutate state. We can make a new object with the payload.

  // Make sure to catch your errors and handle accordingly.
  if (action.error) {

    // #TODO: Remove this line once errors are handled.
    throw `The error was: ${new Error(action.payload)}`

    // switch (action.payload) {
      // Error handling code.
    // }
  }

  switch (action.type) {
    case FETCH_PRODUCTS: {

      let products;
      const data = action.payload.data;

      if (data) {
        products = data.results.map((product) => {
          let image_url;

          if (product.MainImage) {
            image_url = product.MainImage.url_170x135 || null;
          }

          return {
            image_url,
            id: product.listing_id,
            price: product.currency_code,
            description: product.description,
            title: product.title,
          }
        });
      } else {
        products = { error: 'payload invalid.' };
      }

      return [...products, ...state]
    }
  }

  return state;
}


/////  ORIGINAL PRODUCT RESULTS PAGE FOR ETSY WORKING /////
import React, { Component } from "react";
import { connect } from "react-redux";
import { Link } from "react-router-dom";
import { Field, reduxForm } from 'redux-form';


// this.props.products.results[10]
// (because Redux already returned as payload: response.data)

class ProductResults extends Component {

  //
  // constructor(){
  //   super();
  //   console.log('WE ARE IN ProductResults');
  // }
  //
  // componentWillMount(){
  //   console.log('products', this.props.products);
  // }

  renderProducts(products) {
    const title = products.title;
    const imgURL = products.image_url;
    const id = products.id;

    return (
      <tr key={ id }>
        <td>{ title }</td>
        <td><img src={ imgURL }/></td>
      </tr>
    );
  }

  render(){
    const products = this.props.products;

    if(products && products.length) {
      return (
        <table className="table table-hover">
          <thead>
            <tr>
              <th>Title</th>
              <th>Image</th>
            </tr>
          </thead>
          <tbody>
            {products.map(this.renderProducts)}
          </tbody>
        </table>
      );

    } else {

      return(
        <div>LOADING...</div>
      );

    }

  } //render
}

function mapStateToProps({ products }) {
  return { products };
}

export default connect(mapStateToProps)(ProductResults);
