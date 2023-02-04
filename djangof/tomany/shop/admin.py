from django.contrib import admin
from .models import Cart, CartProduct, Category, Favourite, Product, Order, User
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

admin.site.register([Cart, CartProduct, Category, Favourite, Product, Order
                     ])


class UserModelAdmin(BaseUserAdmin):
    list_display = ('id', 'email', 'name', 'is_admin', 'tc')
    list_filter = ('is_admin', )
    fieldsets = (
        ('User Credentials', {'fields': ('email', 'password')}),
        ('Personal info', {'fields': ('name', 'tc')}),
        ('Permissions', {'fields': ('is_admin',)}),
        ('Site Info', {'fields': ('credits', )}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'name', 'tc', 'password1', 'password2', 'credits'),
        }),
    )
    search_fields = ('email',)
    ordering = ('email',)
    filter_horizontal = ()


admin.site.register(User, UserModelAdmin)
