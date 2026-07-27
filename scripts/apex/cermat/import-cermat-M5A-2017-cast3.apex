String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M5A 2017 – úloha 8',
  new List<String>{'Ve čtvercové síti jsou umístěny tři tmavé obrazce $A$, $B$ a $C$. Obsah jednoho čtverečku ve čtvercové síti je $1$ cm². Krajní body úseček jsou v mřížových bodech.','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).','8.1 Obsah obrazce $A$ je $4$ cm².','8.2 Obsah obrazce $B$ je o $1$ cm² menší než obsah obrazce $A$.','8.3 Obsah obrazce $C$ je $5$ cm².'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 230" font-family="sans-serif"><path d="M15 15V215M55 15V215M95 15V215M135 15V215M175 15V215M215 15V215M255 15V215M295 15V215M335 15V215M375 15V215M415 15V215M455 15V215M495 15V215M535 15V215M15 15H535M15 55H535M15 95H535M15 135H535M15 175H535M15 215H535" stroke="#888" fill="none"/><polygon points="55,135 95,95 175,55 175,95 135,135" fill="#dcdcdc" stroke="#000" stroke-width="3"/><polygon points="255,135 255,95 335,55 335,95" fill="#dcdcdc" stroke="#000" stroke-width="3"/><polygon points="415,55 435.0,75.0 455,55 495,95 475.0,115.0 495,135 455,175 435.0,155.0 415,175 375,135 395.0,115.0 375,95" fill="#dcdcdc" stroke="#000" stroke-width="3"/><rect x="415" y="95" width="40" height="40" fill="#fff" stroke="#000" stroke-width="3"/><text x="107.0" y="73.0" font-size="21" text-anchor="middle">A</text><text x="267.0" y="73.0" font-size="21" text-anchor="middle">B</text><text x="387.0" y="73.0" font-size="21" text-anchor="middle">C</text></svg>',
  'ctvercova-sit.svg',
  'Čtvercová síť 13 krát 5 se třemi tmavými obrazci: A je pětiúhelník, B rovnoběžník a C hvězdicový obrazec s bílým čtvercem uprostřed.',
  'Výchozí obrázek k úloze 8 (schematický nákres)',
  new List<String>{'8.1 Obrazec $A$ se dá rozdělit na trojúhelník a lichoběžník, jeho obsah je $3$ cm², nikoli $4$ cm² → Ne.','8.2 Obrazec $B$ je rovnoběžník se základnou $2$ čtverečky a výškou $1$ čtvereček, tedy obsah $2$ cm². Platí $3-2=1$ → Ano.','8.3 Obrazec $C$ leží ve čtverci $3\\times 3$ čtverečky; po odečtení čtyř rohových a čtyř zářezových trojúhelníků má vnější obrys obsah $6$ cm², bílý čtverec uprostřed má $1$ cm², takže tmavá část má $6-1=5$ cm² → Ano.'},
  '8.1: Ne; 8.2: Ano; 8.3: Ano',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2017 – úloha 9',
  new List<String>{'Chlapec trénoval střelbu na koš. Z prvních 12 pokusů se 9krát netrefil. Ve všech dalších pokusech byl s výjimkou jediného, předposledního hodu, úspěšný. Dosáhl tak přesně poloviční úspěšnosti (v polovině pokusů se trefil do koše).','Kolikrát chlapec vystřelil na koš?'},
  new List<String>{'A) méně než 22krát','B) 22krát','C) 23krát','D) více než 23krát','E) Poloviční úspěšnosti nebylo možné dosáhnout.'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Z prvních 12 pokusů byly 3 úspěšné a 9 neúspěšných. Označme $n$ počet dalších pokusů; z nich byl neúspěšný právě jeden, takže úspěšných je $n-1$.','Celkem: pokusů $12+n$, zásahů $3+(n-1)=n+2$, nezdarů $10$. Poloviční úspěšnost znamená, že zásahů je stejně jako nezdarů: $n+2=10$, tedy $n=8$.','Chlapec vystřelil $12+8=20$krát, což je méně než 22krát.'},
  'A) méně než 22krát',
  2, 5, '4',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2017 – úloha 10',
  new List<String>{'Děti si na výletě rozebraly 48 banánů. Některé děti si vzaly po jednom banánu, o 6 dětí méně si vzalo po dvou banánech a poslední, Anička, si jako jediná nevzala ani jeden banán.','Kolik dětí bylo na výletě?'},
  new List<String>{'A) méně než 35','B) 35','C) 36','D) 37','E) více než 37'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť $x$ je počet dětí, které si vzaly jeden banán; po dvou banánech si vzalo $x-6$ dětí.','Banánů je $x+2(x-6)=48$, tedy $3x-12=48$, $3x=60$ a $x=20$.','Po dvou banánech si vzalo $14$ dětí. Celkem $20+14+1=35$ dětí (včetně Aničky).'},
  'B) 35',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
