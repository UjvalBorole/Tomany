from django.db import models
from django.conf import settings
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser
# from django.contrib.auth.models import User, BaseUserManager, AbstractBaseUser

User = settings.AUTH_USER_MODEL


class Category(models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return self.title


class Product(models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    image = models.ImageField(upload_to="products/")
    market_price = models.PositiveIntegerField()
    selling_price = models.PositiveIntegerField()
    description = models.TextField()

    def __str__(self):
        return self.title


class Favourite(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    isFavourite = models.BooleanField(default=False)

    def __str__(self):
        return f"productID = {self.product.id} user = {self.user.username} |isFavourite = {self.isFavourite}"


class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    total = models.PositiveIntegerField()
    isComplete = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"User={self.user.username}|IScomplete={self.isComplete}"


class CartProduct(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ManyToManyField(Product)
    price = models.PositiveIntegerField()
    quantity = models.PositiveIntegerField()
    subtotal = models.PositiveIntegerField()

    def __Str__(self):
        return f"Cart=={self.cart.id}<==>CartProduct:{self.id}==Quantity=={self.quantity}"


class Order(models.Model):
    cart = models.OneToOneField(Cart, on_delete=models.CASCADE)
    email = models.EmailField()
    phone = models.IntegerField()
    address = models.CharField(max_length=200)


# Custom User JWT
class UserManager(BaseUserManager):
    def create_user(self, email, name, tc, password=None, password2=None):
        """
        Creates and saves a User with the given email, name, tc, password=None, password2=None and password.
        """
        if not email:
            raise ValueError('Users must have an email address')

        user = self.model(
            email=self.normalize_email(email),
            name=name,
            tc=tc,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, name, tc, password=None, password2=None):
        """
        Creates and saves a superuser with the given email,  name, tc, password=None, password2=None
        """
        user = self.create_user(
            email,
            password=password,
            name=name,
            tc=tc,
        )
        user.is_admin = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser):
    email = models.EmailField(
        max_length=255,
        unique=True,
    )

    name = models.CharField(max_length=200)
    tc = models.BooleanField(default=True)
    credits = models.PositiveIntegerField(default=100)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)

    objects = UserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name', 'tc']

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return self.is_admin

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin
