from rest_framework.response import Response
from rest_framework.views import APIView
from .models import *
from .serializer import *
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework import status
from django.contrib.auth import authenticate
from .renders import UserRenderer
from rest_framework_simplejwt.tokens import RefreshToken

from django.conf import settings
User = settings.AUTH_USER_MODEL

# Generate Token Manually


def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)

    return {
        'refresh': str(refresh),
        'access': str(refresh.access_token),
    }


class ProductView(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def get(self, request):
        query = Product.objects.all()
        data = []
        serializers = ProductSer(query, many=True)
        for pro in serializers.data:
            fab_query = Favourite.objects.filter(
                user=request.user).filter(product_id=pro['id'])

            if fab_query:
                pro['favourite'] = fab_query[0].isFavourite

            else:
                pro['favourite'] = False

            data.append(pro)
            # print(fab_query)
        return Response(data)


class FavouriteView(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def post(self, request):
        data = request.data["id"]
        # print('data', data)
        try:
            product_obj = Product.objects.get(id=data)
            user = request.user
            single_favourite_product = Favourite.objects.filter(
                user=user).filter(product=product_obj).first()  # it means select product,user,isFavourite  from Favourite where user == user and product == product_id and first is used to remove the Script bydefault filter is return the script and first is select the Script's first element
            # it eliminate the repeatations
            if single_favourite_product:
                print(single_favourite_product)
                ccc = single_favourite_product.isFavourite
                # it changes true to false or false to true
                # it menas  single_favourite_product.isFavourite =  !single_favourite_product.isFavourite
                single_favourite_product.isFavourite = not ccc
                print(single_favourite_product)
                single_favourite_product.save()
                response_msg = {'error': False}
            else:
                Favourite.objects.create(
                    product=product_obj, user=user, isFavourite=True)
                response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class RegisterView(APIView):
    def post(self, request):
        serializers = Userserializer(data=request.data)
        # print(request.data)
        if serializers.is_valid():
            serializers.save()
            return Response({"error": False})
        return Response({"error": True})


class CartView(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def get(self, request):
        user = request.user
        try:
            cart_obj = Cart.objects.filter(user=user).filter(isComplete=False)
            data = []
            cart_serializer = CartSerializers(cart_obj, many=True)
            for cart in cart_serializer.data:
                cart_product_obj = CartProduct.objects.filter(cart=cart["id"])
                # print(cart_product_obj)
                cart_product_obj_serializer = CartProductSerializers(
                    cart_product_obj, many=True)
                # print(cart_product_obj_serializer.data)
                cart['cartproducts'] = cart_product_obj_serializer.data
                data.append(cart)
            response_msg = {'error': False, 'data': data}
        except:
            response_msg = {'error': True, 'data': 'No Data'}
        return Response(response_msg)


class OrderView(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def get(self, request):
        try:
            ordered_data = Order.objects.filter(cart__user=request.user)
            ordered_data_Serializer = OrderSerializers(ordered_data, many=True)
            response_msg = {"error": False,
                            "data": ordered_data_Serializer.data}
        except:
            response_msg = {"error": True, "data": "No Data"}
        return Response(response_msg)


class AddToCart(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def post(self, request):
        product_id = request.data['id']
        # print("id", product_id)
        product_obj = Product.objects.get(id=product_id)  # get the product
        # print("obj", product_obj)
        cart_cart = Cart.objects.filter(
            user=request.user).filter(isComplete=False).first()  # first is used to get the queryset Script/list in to object

        # stu = CartSerializers(cart_cart, many=True)
        cart_product_obj = CartProduct.objects.filter(
            product__id=product_id).first()
        # stu = CartProductSerializers(cart_product_obj)
        try:
            if cart_cart:
                print('cart_cart', cart_cart)
                # vs = cart_cart.cartproduct_set
                # print(vs)
                # when we create the relation foreignkey the relation of two model are make to access the element of two model
                # In this case we create relation of cart and cartproduct of foreignkey relation so cart also access the cartproducts models attributes
                # so car_cart means Cart model and cartproduct of small letter ans _set is means set of cartproduct total means cart of cartproduct set and filter cartproducts product's productobj
                this_product_in_cart = cart_cart.cartproduct_set.filter(
                    product=product_obj)  # After matching query
                # print('this_product_in_cart', this_product_in_cart)
                if this_product_in_cart.exists():
                    # At the time the produc the in cart and also in cartproduct
                    cartprod = CartProduct.objects.filter(
                        product=product_obj).filter(cart__isComplete=False).first()
                    print(cartprod)
                    print("data updated")

                    print(cartprod.quantity)
                    cartprod.quantity += 1
                    cartprod.subtotal += product_obj.selling_price
                    cartprod.save()
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
                    print("data updated")
                else:
                    # at the time the product is in cart but not in cartproduct
                    cart_product_new = CartProduct.objects.create(
                        cart=cart_cart,
                        # product=product_obj,
                        price=product_obj.selling_price,
                        quantity=1,
                        subtotal=product_obj.selling_price
                    )
                    cart_product_new.product.add(product_obj)
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
            else:
                # at the time the product is not in cart and also not in cartproduct
                Cart.objects.create(user=request.user,
                                    total=0, isComplete=False)
                new_cart = Cart.objects.filter(
                    user=request.user
                ).filter(isComplete=False).first()
                cart_product_new = CartProduct.objects.create(
                    cart=new_cart,
                    price=product_obj.selling_price,
                    quantity=1,
                    subtotal=product_obj.selling_price
                )
                cart_product_new.product.add(product_obj)
                new_cart.total += product_obj.selling_price
                new_cart.save()

            response_msg = {
                'error': False, 'message': "Product add to card successfully", "Product_id": product_id
            }

        except:
            response_msg = {
                'error': True, 'message': "Product Not add! Something is went Wrong"
            }
        return Response(response_msg)


class DeleteSingleCart(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def post(self, request):
        id = request.data['id']
        try:
            cart_prod_obj = CartProduct.objects.get(id=id)
            cart_cart = Cart.objects.filter(
                user=request.user).filter(isComplete=False).first()
            cart_cart.total -= cart_prod_obj.subtotal
            cart_prod_obj.delete()
            cart_cart.save()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class DeleteCart(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def post(self, request):
        cart_id = request.data['id']
        try:
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.delete()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class OrderCreate(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def post(self, request):
        try:
            data = request.data
            print(data)
            cart_id = data['cartid']
            address = data['address']
            email = data['email']
            phone = data['phone']
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.isComplete = True
            cart_obj.save()
            Order.objects.create(
                cart=cart_obj,
                address=address,
                email=email,
                phone=phone,
            )
            response_msg = {"error": False,
                            "message": "Your Order is Complete"}
        except:
            response_msg = {"error": True,
                            "message": "Something is went Wrong"}
        return Response(response_msg)


class Userdata(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]

    def get(self, request):
        try:
            data = []
            user = request.user
            print('user')
            us = User.objects.get(username=user)
            serializer = UserdataSerializer(us)
            data.append(serializer.data)
            request_msg = {"error": False,
                           "data": data}
        except:
            request_msg = {"error": True, "data": "No Data"}
        return Response(request_msg)


class UserRegistrationView(APIView):
    renderer_classes = [UserRenderer,]

    def post(self, request, format=None):
        serializer = UserRegistrationSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            user = serializer.save()
            token = get_tokens_for_user(user)
            return Response({'token': token, 'msg': 'Registration Successful'},
                            status=status.HTTP_201_CREATED)


class UserLoginView(APIView):
    renderer_classes = [UserRenderer,]

    def post(self, request, format=None):
        serializers = UserLoginSerializer(data=request.data)
        if serializers.is_valid(raise_exception=True):
            email = serializers.data.get('email')
            password = serializers.data.get('password')
            user = authenticate(email=email, password=password)
            if user is not None:
                token = get_tokens_for_user(user)
                return Response({'token': token, "msg": "Login Success"}, status=status.HTTP_200_OK)
            else:
                return Response({"errors": {"non_field_errors": ['Email or Password is not Valid']}}, status=status.HTTP_404_NOT_FOUND)


class UserProfileView(APIView):
    permission_classes = [IsAuthenticated,]
    renderer_classes = [UserRenderer,]

    def get(self, request, format=None):
        serializers = UserProfileSerializer(request.user)
        return Response(serializers.data, status=status.HTTP_200_OK)


class UserChangePasswordView(APIView):
    renderer_classes = [UserRenderer]
    permission_classes = [IsAuthenticated]

    def post(self, request, format=None):
        serializers = UserChangePasswordSerializer(
            data=request.data, context={'user': request.user})
        if serializers.is_valid(raise_exception=True):
            return Response({"msg": "Password Change Successfully"}, status=status.HTTP_200_OK)
        return Response(serializers.errors, status=status.HTTP_404_NOT_FOUND)


class SendPasswordResetEmailView(APIView):
    renderer_classes = [UserRenderer]

    def post(self, request, format=None):
        serializers = SendPasswordResetEmailSerializer(data=request.data)
        if serializers.is_valid(raise_exception=True):
            return Response({"msg": "Email send Successfully"}, status=status.HTTP_200_OK)
        return Response(serializers.errors, status=status.HTTP_404_NOT_FOUND)
