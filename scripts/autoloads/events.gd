extends Node

# Отсчёт закончился
signal game_start
# Когда тебя укусили или зверёк сбежал (нужно начать сначала) - оба варианта
signal game_lose

# Смена состояния зверька
signal new_animal_state(state: Global.STATES)

# Когда ты слишком быстро двигаешь рукой (на это реагирует зверёк)
signal speed_limit_reached
# Когда ты коснулся зверька зря (он пугается)
signal animal_touched
# Зверёк укусил за руку
signal got_hurt
# Зверёк укусил еду
signal chomp_successful(food: Global.FOOD)
# Зверёк довольный, мы его накормили полностью
signal satisfied_animal

# Начало перехода на сцену new_scene
signal transition_start(new_scene: Global.GAME_SCENES)
# Конец перехода на сцену new_scene
signal transition_complete(new_scene: Global.GAME_SCENES)

# Будет использоваться, когда мы прошли абсолютно все локации
signal game_win
# Ещё нигде не применялось, но можно использовать, если вдруг сделаем настройки громкости
signal volume_changed

# Это нигде не считывается, мы просто отправляем этот сигнал для тряски камеры на выбранное кол-во символов
signal screen_shake
