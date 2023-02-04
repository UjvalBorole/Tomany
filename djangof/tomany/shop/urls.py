from django.urls import path
from .views import *
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('products/', ProductView.as_view()),
    path('favourite/', FavouriteView.as_view()),
    path('login/', obtain_auth_token),
    path('register/', RegisterView.as_view()),
    path('cart/', CartView.as_view()),
    path('order/', OrderView.as_view()),
    path('addtocart/', AddToCart.as_view()),
    path('deletesingle/', DeleteSingleCart.as_view()),
    path('deletecart/', DeleteCart.as_view()),
    path('ordernow/', OrderCreate.as_view()),
    path('user/', Userdata.as_view()),
    path('signup/', UserRegistrationView.as_view()),
    path('log/', UserLoginView.as_view()),
    path('profile/', UserProfileView.as_view()),
    path('changepass/', UserChangePasswordView.as_view()),
    path('send-password-reset-email/', SendPasswordResetEmailView.as_view()),
]
