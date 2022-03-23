#!/usr/bin/env python
# coding: utf-8

# In[1]:


from IPython.display import YouTubeVideo
YouTubeVideo('lyDLAutA88s', width=800, height=300)


# In[2]:


# 1. Посмотрите видео Дэвида Бизли про всроенные инструменты Python
# 2. Попробуйте используя встроенные инструменты Python проанизировать таблицу из файла "Vacancy.csv"
# 3. Попробуйте ответить на вопросы:
# Сколько вакансий, которые вам нравятся?
# Насколько свежие эти вакансии?
# Сколько вакансий с позициями на которых вы работаете?
# Сколько вакансий для аналатика данных?
# Сколько вакансий для аналитика данных с использованием Python?

# В задании важно не использовать pandas и numpy, а встроенные инструменты python
# Counter, CSV, defaultdict, sorted


# In[3]:


import csv


# In[4]:


import sys


# In[5]:


from collections import Counter
from collections import defaultdict


# In[6]:


csv.field_size_limit(sys.maxsize)


# In[7]:


vacs = list(csv.DictReader(open('Vacancy.csv')))


# In[8]:


len(vacs)


# In[9]:


{ row['vacstatus'] for row in vacs}


# In[10]:


# 1. Сколько вакансий, которые вам нравятся?
# Вакансии Аналитик данных в спб:

like = [row for row in vacs if row['vactitle'].find('Аналитик данных') != -1]
print('Вакансий дата-аналитика: ', len(like))


# In[11]:


# 2. Насколько свежие эти вакансии?
act_date = Counter(row['vacdate'] for row in like)
act_date.most_common()


# In[15]:


# 3. Сколько вакансий с позициями на которых вы работаете?

km = [ row for row in vacs if row['vactitle'].find('Клиентский менеджер') != -1]
'Вакансий с позициями, на которых вы работаете: ', len(km)


# In[16]:


# 4. Сколько вакансий для аналитика данных?

da_vacs = [row for row in vacs if row['vactitle'].find('Аналитик данных') != -1 or row['vactitle'].find('Data analyst') != -1]
'Вакансий для аналитика данных: ', len(da_vacs)


# In[17]:


# 5. Сколько вакансий для аналитика данных с использованием Python?

da_vacs_w_python = [row for row in vacs if row['vactitle'].find('Аналитик данных') != -1 
           or row['vactitle'].find('Data analyst') != -1
            and row['vacdescription'].find('Python') != -1]

'Вакансий для аналитика данных с использованием Python: ', len(da_vacs_w_python)


# In[ ]:




