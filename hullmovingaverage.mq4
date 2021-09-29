//+------------------------------------------------------------------+
//|                                            hullmovingaverage.mq4 |
//|    Copyright 24-10-2020, Bools AND Strings software Corporation. |
//|                                                      www.B&S.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 24-10-2020, Bools AND Strings software Corporation."
#property link      "www.B&S.com"
#property version   "1.00"
#property strict
#include <customfunction.mqh>
int periodvalue = 200;
void OnStart()
  {
   Alert(" ");
   Alert(" ");
      // calculating wma for 100 days shift 
      double WMA1 = iMA(NULL,0,100,1,MODE_LWMA,PRICE_CLOSE,0);
      double MA1 = 2*WMA1;
      double WMA2 = iMA(NULL,0,200,1,MODE_LWMA,PRICE_CLOSE,0);
      double first = (MA1-WMA2);
      double WMA3 = iMA(NULL,0,100,2,MODE_LWMA,PRICE_CLOSE,0);
      double MA2 = 2*WMA2;
      double WMA4 = iMA(NULL,0,200,2,MODE_LWMA,PRICE_CLOSE,0);
      double second = (MA2-WMA4);
      double WMA5 = iMA(NULL,0,100,3,MODE_LWMA,PRICE_CLOSE,0);
      double MA3 = 2*WMA5;
      double WMA6 = iMA(NULL,0,200,3,MODE_LWMA,PRICE_CLOSE,0);
      double third = (MA3-WMA6);
      double WMA7 = iMA(NULL,0,100,4,MODE_LWMA,PRICE_CLOSE,0);
      double MA4 = 2*WMA7;
      double WMA8 = iMA(NULL,0,200,4,MODE_LWMA,PRICE_CLOSE,0);
      double fourth = (MA4-WMA8);
      
      // calculating hull moving average
      // assigning weights 
      double weightedsum = first*0.40+second*0.30+third*0.20+fourth*0.10;
      double HMA = NormalizeDouble(weightedsum,2);
      /*Alert("first:" + first);
      Alert("second:" + second);
      Alert("Third:" + third);
      Alert("Fourth:" + fourth);*/
      Alert("HMA:" + HMA);
      
      if(!CheckIfOpenOrdersByMagicNB(2000))
      {
        if(Close[2]>HMA && Close[1]<HMA)
        {
            double stoploss = Bid+200;
            double takeprofit = Bid-200;
            int OrderID = OrderSend(NULL,OP_SELL,0.10,Bid,0,stoploss,takeprofit,NULL,2000);
            Alert("Buy Order");
            Alert("Stoploss:" + stoploss);
            Alert("Takeprofit:" + takeprofit);
            
            
        }
        else if(Close[2]<HMA && Close[1]>HMA)
        {
            double stoploss2 = Ask-200;
            double takeprofit2 = Ask+200;
            int OrderID2 = OrderSend(NULL,OP_BUY,0.10,Ask,0,stoploss2,takeprofit2,NULL,2000);
            Alert("Sell Order");
            Alert("Stoploss:" + stoploss2);
            Alert("Takeprofit:" + takeprofit2);
        }
        
            Alert("Close1:" + Close[1]);
            Alert("Close2:" + Close[2]);
      }
      
      
      
      
      
  }
//+------------------------------------------------------------------+
