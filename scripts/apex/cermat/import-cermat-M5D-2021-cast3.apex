String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD21C0T04';
Integer YEAR = 2021;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5D 2021 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $N$, $O$, $P$ (viz obrázek).','Body $N$, $O$ jsou středy protějších stran $AB$ a $CD$ obdélníku $ABCD$ a bod $P$ leží na straně $BC$ tohoto obdélníku.','Sestrojte vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <rect x="6" y="6" width="448" height="288" fill="none" stroke="#ccc"/> <text x="184" y="110" font-size="16">×</text><text x="182" y="128" font-size="15" font-style="italic">O</text> <text x="356" y="110" font-size="16">×</text><text x="354" y="128" font-size="15" font-style="italic">P</text> <text x="206" y="196" font-size="16">×</text><text x="204" y="214" font-size="15" font-style="italic">N</text> </svg>',
  'body-nop.svg',
  'Tři body N, O, P v rovině.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Přímka $NO$ je osou obdélníku kolmou ke stranám $AB$ a $CD$. V bodě $N$ vztyčíme kolmici k $NO$ (přímka $AB$), v bodě $O$ kolmici k $NO$ (přímka $CD$). Bodem $P$ vedeme rovnoběžku s $NO$ (přímka $BC$); ta protne přímku $AB$ ve vrcholu $B$ a přímku $CD$ ve vrcholu $C$. Vrchol $A$ je obrazem $B$ v souměrnosti podle $N$, vrchol $D$ obrazem $C$ podle $O$.'},
  'Konstrukce obdélníku $ABCD$: $N$ střed strany $AB$, $O$ střed strany $CD$, $P$ na straně $BC$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2021 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží polopřímka $LS$ a bod $U$ (viz obrázek).','Bod $L$ je vrchol rovnoramenného trojúhelníku $KLM$, bod $S$ je střed strany $LM$. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod $U$ leží uvnitř trojúhelníku $KLM$.','Sestrojte vrcholy $K$, $M$ trojúhelníku $KLM$, označte je písmeny a trojúhelník narýsujte. Najděte všechna $3$ řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <rect x="6" y="6" width="448" height="288" fill="none" stroke="#ccc"/> <line x1="330" y1="60" x2="430" y2="260" stroke="#000" stroke-width="2"/> <line x1="374" y1="196" x2="392" y2="184" stroke="#000" stroke-width="1.4"/> <text x="398" y="196" font-size="15" font-style="italic">S</text> <text x="428" y="270" font-size="15" font-style="italic">L</text> <text x="352" y="204" font-size="16">×</text><text x="350" y="222" font-size="15" font-style="italic">U</text> </svg>',
  'poloprimka-ls.svg',
  'Polopřímka LS a bod U ležící vlevo od ní.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Bod $S$ je střed $LM$, proto bod $M$ leží na polopřímce $LS$ tak, že $|LM|=2|LS|$. Podle toho, která strana je základna (ramena jsou dvakrát delší než základna), vznikají tři rovnoramenné trojúhelníky $KLM$; vrchol $K$ se v každém případě volí tak, aby bod $U$ ležel uvnitř trojúhelníku. Úloha má tři řešení $K_1$, $K_2$, $K_3$.'},
  'Tři rovnoramenné trojúhelníky $KLM$ ($M$ na polopřímce $LS$, $|LM|=2|LS|$; vrcholy $K_1$, $K_2$, $K_3$) – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
