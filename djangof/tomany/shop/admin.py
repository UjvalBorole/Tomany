from django.contrib import admin
from .models import Cart, CartProduct, Category, Favourite, Product, Order

admin.site.register([Cart, CartProduct, Category, Favourite, Product, Order
                     ])
