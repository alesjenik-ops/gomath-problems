String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD22C0T04';
Integer YEAR = 2022;

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
  'CERMAT M5D 2022 – úloha 12',
  new List<String>{'Na podložce je postavena stavba ze $6$ stejných krychliček a $2$ stejných kvádrů. Na obrázku je stavba a její pohled zepředu.','Který z obrázků (A–E) může představovat pohled na stavbu zezadu?'},
  new List<String>{'A) obrázek A','B) obrázek B','C) obrázek C','D) obrázek D','E) žádný z uvedených obrázků'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif"><text x="110" y="24" font-size="13" text-anchor="middle">Stavba</text><polygon points="50,52 65,41 105,41 90,52" fill="#efefef" stroke="#000" stroke-width="1.4"/><polygon points="90,52 105,41 105,81 90,92" fill="#d8d8d8" stroke="#000" stroke-width="1.4"/><rect x="50" y="52" width="40" height="40" fill="#ffffff" stroke="#000" stroke-width="1.4"/><polygon points="50,92 65,81 105,81 90,92" fill="#efefef" stroke="#000" stroke-width="1.4"/><polygon points="90,92 105,81 105,121 90,132" fill="#d8d8d8" stroke="#000" stroke-width="1.4"/><rect x="50" y="92" width="40" height="40" fill="#ffffff" stroke="#000" stroke-width="1.4"/><polygon points="92,92 107,81 147,81 132,92" fill="#efefef" stroke="#000" stroke-width="1.4"/><polygon points="132,92 147,81 147,121 132,132" fill="#d8d8d8" stroke="#000" stroke-width="1.4"/><rect x="92" y="92" width="40" height="40" fill="#ffffff" stroke="#000" stroke-width="1.4"/><polygon points="50,132 65,121 105,121 90,132" fill="#efefef" stroke="#000" stroke-width="1.4"/><polygon points="90,132 105,121 105,161 90,172" fill="#d8d8d8" stroke="#000" stroke-width="1.4"/><rect x="50" y="132" width="40" height="40" fill="#ffffff" stroke="#000" stroke-width="1.4"/><polygon points="92,132 107,121 147,121 132,132" fill="#efefef" stroke="#000" stroke-width="1.4"/><polygon points="132,132 147,121 147,161 132,172" fill="#d8d8d8" stroke="#000" stroke-width="1.4"/><rect x="92" y="132" width="40" height="40" fill="#ffffff" stroke="#000" stroke-width="1.4"/><polygon points="134,132 149,121 189,121 174,132" fill="#efefef" stroke="#000" stroke-width="1.4"/><polygon points="174,132 189,121 189,161 174,172" fill="#d8d8d8" stroke="#000" stroke-width="1.4"/><rect x="134" y="132" width="40" height="40" fill="#ffffff" stroke="#000" stroke-width="1.4"/><text x="330" y="24" font-size="13" text-anchor="middle">Pohled zepředu</text><rect x="290" y="66" width="34" height="34" fill="none" stroke="#000" stroke-width="1.6"/><rect x="290" y="100" width="34" height="34" fill="none" stroke="#000" stroke-width="1.6"/><rect x="324" y="100" width="34" height="34" fill="none" stroke="#000" stroke-width="1.6"/><rect x="290" y="134" width="34" height="34" fill="none" stroke="#000" stroke-width="1.6"/><rect x="324" y="134" width="34" height="34" fill="none" stroke="#000" stroke-width="1.6"/><rect x="358" y="134" width="34" height="34" fill="none" stroke="#000" stroke-width="1.6"/></svg>',
  'stavba.svg',
  'Schematická stavba (schodiště klesající vpravo) a její pohled zepředu; obrázky A–E jsou v testovém sešitu.',
  'Stavba a pohled zepředu (obrázky A–E viz testový sešit)',
  new List<String>{'Pohled zezadu je zrcadlově obrácený pohled zepředu, tedy schodiště stoupající na opačnou stranu. Tomu odpovídá obrázek $A$.'},
  'A) obrázek A',
  2, 3, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2022 – úloha 13',
  new List<String>{'Přiřaďte ke každé úloze (13.1–13.3) odpovídající výsledek (A–F).','13.1 Do 1. třídy chodí $24$ žáků, přitom chlapců je dvakrát více než dívek. Kolik chlapců chodí do 1. třídy?','13.2 Do 2. třídy chodí $25$ žáků. Když chyběli $3$ chlapci a $2$ dívky, bylo mezi přítomnými chlapců o $4$ více než dívek. Kolik chlapců chodí do 2. třídy?','13.3 Do 3. třídy chodí chlapců o pětinu méně než dívek. Počty dívek a chlapců se liší o $3$. Kolik chlapců chodí do 3. třídy?'},
  new List<String>{'A) 12 chlapců','B) 13 chlapců','C) 14 chlapců','D) 15 chlapců','E) 16 chlapců','F) jiný počet chlapců'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'13.1 Dívek $d$, chlapců $2d$, celkem $3d = 24$, tedy $d = 8$ a chlapců je $16$ → E.','13.2 Chlapců $c$, dívek $25 - c$. Přítomných: $(c - 3) - (25 - c - 2) = 4$, tedy $2c - 26 = 4$ a $c = 15$ → D.','13.3 Chlapci mají $\\frac{4}{5}$ počtu dívek, rozdíl je $\\frac{1}{5}$ dívek $= 3$, tedy dívek je $15$ a chlapců $12$ → A.'},
  '13.1: E (16 chlapců); 13.2: D (15 chlapců); 13.3: A (12 chlapců)',
  5, 7, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
