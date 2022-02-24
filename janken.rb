
class Player
  
  def hand
    # プレイヤーにじゃんけんの手を選択させる文章を表示させます。
    puts "数字を入力してください。"
    puts "0:pierre"
    puts "1:papier"
    puts "2:ciseaux"
    puts
    puts
    input_hand = gets

    #On vérifie si le player a entré soit 0, 1 ou 2
    #Lorque on introduit une lettre et on converti on obtient zero
    #Donc il n'y a vait pas le moyen de savoir si c'est une lettre ou un zero lorsque on converti
    #C"est pour cela qu'on prend la valeur en ASCII pour savoir si on est en présence que de 0, 1 ou 2
    if input_hand.unpack('U*')[0] == 48
      input_hand = 0
    elsif input_hand.unpack('U*')[0] == 49
      input_hand = 1
    elsif input_hand.unpack('U*')[0] == 50
      input_hand = 2
    end

    bool = true
    while bool
        bool = (input_hand == 0 || input_hand == 1 || input_hand == 2)
       if bool
        return input_hand
       else
        print "\e[2J\e[f" #On efface l'écran
        puts "Veuillez saisir un nombre entre 0 et 2"
        puts
        jeux = Player.new
        jeux.hand
       end
    end
  end
end

class Enemy
  def hand
    return rand(0..2)
    # グー、チョキ、パーの値をランダムに取得する。
  end
end

class Janken
  def pon(player_hand, enemy_hand)
    # 変数「janken」に["グー", "チョキ", "パー"]を代入します。
    janken = ["pierre", "papier", "ciseaux"] #0 : pierre, 1 : papier et 2 : ciseaux
    #「相手の手は#{相手の手}です。」と出力させます。
    #puts "enemy : #{enemy_hand}"
    #puts "La main de l'adversiare est #{janken[enemy_hand]}"
    # Playerクラスの戻り値とEnemyクラスの戻り値からじゃんけんするロジックを作成します。
    # Playerクラスの戻り値(player_hand)とEnemyクラスの戻り値(enemy_hand)の値が同じだった場合
    if ((player_hand == 0 && enemy_hand == 2) || (player_hand == 1 && enemy_hand == 0) || (player_hand == 2 && enemy_hand == 1))
      # 「あいこ」を出力します。
      puts "La main de l'adversaire est #{janken[enemy_hand]}, vous gagné"
      return false
      #「true」を返してじゃんけんを繰り返し実行させます。
      # ヒント：「return」を使って戻り値を返すことができます。しかし、Rubyでは戻り値を返す場合、「return」を省略するのが一般的です。
    elsif ((player_hand == 0 && enemy_hand == 1) || (player_hand == 1 && enemy_hand == 2) || (player_hand == 2 && enemy_hand == 0)) # もしも下記の組み合わせだった場合
      # (player_hand == 0 && enemy_hand == 1) || (player_hand == 1 && enemy_hand == 2) || (player_hand == 2 && enemy_hand == 0)
      #「あなたの勝ちです」を出力します。
      #「false」を返してじゃんけんを終了させます。
      puts "La main de l'adversaire est #{janken[enemy_hand]}, vous perdez"
      return false
    elsif ((player_hand == 0 && enemy_hand == 0) || (player_hand == 1 && enemy_hand == 1) || (player_hand == 2 && enemy_hand == 2))
      #「あなたの負けです」を出力します。
      #「false」を返してじゃんけんを終了させます。
       puts "La main de l'adversaire est #{janken[enemy_hand]}, c'est un match nul"
       return true
    end
  end
end

class GameStart
  # selfを使用することで、GameStartをインスタンス化することなく、クラス名を使ってjankenponメソッドを呼び出せます。
  def self.jankenpon
    # 変数「player」にPlayerをインスタンス化したものを代入します。
    player = Player.new
    # 変数「enemy」にEnemyをインスタンス化したものを代入します。
    enemy = Enemy.new
    # 変数「janken」にJankenをインスタンス化したものを代入します。
    janken = Janken.new
    # 変数「next_game」に「true」を代入しましょう。
    # 「next_game」が「false」だと繰り返し処理を終了し、「true」だと繰り返し処理を継続します。
    next_game = true
    while next_game  
      # 変数「next_game」にじゃんけんを実行して返ってきた値(戻り値)を代入します。
      #「janken.pon(player.hand, enemy.hand)」でじゃんけんを実行しています。
      next_game = janken.pon(player.hand, enemy.hand)
    end
  end
end

GameStart.jankenpon