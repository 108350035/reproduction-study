# reproduction-study
《Area-Efficient Parallel FIR Digital Filter Structures for Symmetric Convolutions Based on Fast FIR Algorithm》論文的重現練習

Step 1.除了研讀該論文，也要研讀論文裡引用之論文  《Low-Area/Power Parallel FIR Digital Filter Implementations》

與《Frequency Spectrum Based Low-Area Low-Power Parrallel FIR Filter Design》

Step 2.論文只將現有的公式進一步優化，並且未給代碼。因此要自己慢慢揣摩，先實作於matlab，最後在實作於verilog

Step 3.實作濾波器長度為24-tap  位元寬為16bit，因太花時間加上其他大同小異，就沒有繼續作。結果如下(DC綜合用180nm process，後模擬功能皆正常、無時序違規，有需要自己拿去綜合看結果，僅提供綜合後肢面積與時序)

![image](https://github.com/108350035/reproduction-study/blob/main/matlab.jpg)

![image](https://github.com/108350035/reproduction-study/blob/main/verdi%E6%B3%A2%E5%BD%A2.PNG)





