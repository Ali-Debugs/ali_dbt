{%- set apples = ['fuji', 'gala', 'honeycrisp', 'granny smith', 'pink lady'] -%}

{%- for i in apples %}
    {%- if i!= 'honeycrisp' %}
    {{ i }}
    {% else %}
    I hate {{ i }} apples
    {% endif %}
{%- endfor %}
 