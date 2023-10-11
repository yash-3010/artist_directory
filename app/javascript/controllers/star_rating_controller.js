import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="star-rating"

export default class extends Controller {
  static targets = ['star', 'inpt'];
  static values = { rating: Number };

  initialize() {
    this.rating = 0;
  }

  connect() {
    this.updateStars();
    console.log('Star Rating Controller Connected');
  }

  select(event) {
    this.rating = event.target.dataset.value;
    this.updateStars();
    this.inptTarget.value = parseInt(this.rating);
    console.log(this.inptTarget.value);
  }

  updateStars() {
    this.starTargets.forEach((star, index) => {
      if (index < this.rating) {
        star.classList.add('bi-star-fill');
        star.classList.add('str-slect')
        star.classList.remove('bi-star');
      } else {
        star.classList.remove('bi-star-fill');
        star.classList.remove('str-slect')
        star.classList.add('bi-star');
      }
    });
  }
}
