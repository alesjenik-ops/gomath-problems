String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M5A 2020 – úloha 5',
  new List<String>{'Kouzelník přinesl víle kouzelný podnos se 42 bílými perlami. Víla z podnosu odebírala perly na šperky. Za každou odebranou bílou perlu se na podnose okamžitě vykouzlily 4 růžové perly, ale na růžové perly kouzlo nefungovalo. Z prvních 30 odebraných bílých perel víla vytvořila náhrdelník. Když ho dokončila, začala z podnosu odebírat další perly (bílé i růžové) na korunku. Perly na korunku odebírala tak dlouho, dokud nebyl podnos prázdný.','5.1 Vypočtěte, kolik perel bylo na podnose, když víla dokončila náhrdelník.','5.2 Vypočtěte, kolik perel odebrala víla z podnosu na korunku.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Víla odebrala $30$ bílých perel (zbývá $42-30=12$ bílých) a vykouzlila $30\\cdot 4=120$ růžových; na podnose je $12+120=132$ perel.','5.2 Zbývá odebrat $12$ bílých a $120$ růžových. Odběrem $12$ bílých vznikne dalších $12\\cdot 4=48$ růžových. Celkem na korunku: $12+120+48=180$ perel.'},
  '5.1: $132$ perel; 5.2: $180$ perel',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2020 – úloha 6',
  new List<String>{'Každý ze tří spolužáků měl zapsat co nejvíce hlavních měst evropských států. Adam zapsal 12 hlavních měst, stejně jako Bětka, ale Eliška jich zapsala jen 6. Mezi všemi zapsanými hlavními městy byla 2 města zapsána třikrát, 7 měst dvakrát a ostatní jen jedenkrát.','6.1 Vypočtěte, kolik hlavních měst bylo zapsáno jen jedenkrát.','6.2 Vypočtěte, kolik různých hlavních měst bylo celkem zapsáno.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Celkem bylo zapsáno $12+12+6=30$ měst (i s opakováním). Třikrát zapsaná $2$ města a dvakrát $7$ měst dají $2\\cdot 3+7\\cdot 2=20$ zápisů; zbylých $30-20=10$ měst je zapsáno jen jednou.','6.2 Různých měst je $2+7+10=19$.'},
  '6.1: $10$ hlavních měst; 6.2: $19$ různých hlavních měst',
  4, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2020 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží polopřímka $XY$ a bod $A$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Jiné dva vrcholy tohoto obdélníku leží na polopřímce $XY$ a délka strany $AB$ je 7 cm.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 460" font-family="sans-serif"> <line x1="110" y1="420" x2="560" y2="150" stroke="#000" stroke-width="2"/> <circle cx="110" cy="420" r="3.5" fill="#000"/> <text x="88" y="437" font-size="17" font-style="italic">X</text> <circle cx="308" cy="301" r="3.5" fill="#000"/> <text x="300" y="291" font-size="17" font-style="italic">Y</text> <text x="322" y="392" font-size="17" text-anchor="middle">×</text> <text x="322" y="412" font-size="17" font-style="italic" text-anchor="middle">A</text> </svg>',
  'poloprimka-xy.svg',
  'Polopřímka XY směřující šikmo vzhůru doprava a bod A pod ní.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Sestrojíme obdélník $ABCD$ s daným vrcholem $A$ a stranou $|AB|=7$ cm tak, aby další dva jeho vrcholy ležely na polopřímce $XY$. Úloha má dvě řešení (polohy $B_1 C_1 D_1$ a $B_2 C_2 D_2$) – viz obrázek v klíči.'},
  'Konstrukce obdélníku $ABCD$ ($A$ dán, $|AB|=7$ cm, dva vrcholy na polopřímce $XY$); dvě řešení – viz obrázek v klíči.',
  3, 6, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
