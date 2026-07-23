String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M7A 2019 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Zájezd stojí $14\\,000$ korun. Prvnímu zákazníkovi byla poskytnuta $25\\,\\%$ sleva. Jaká byla cena zájezdu pro prvního zákazníka?','15.2 Zájezd stojí $12\\,000$ korun. Cena zájezdu se skládá ze dvou položek: ceny za pobyt a ceny za dopravu. Cena za dopravu je stejná jako pětina ceny za pobyt. Jaká je cena za samotný pobyt?','15.3 Cena zájezdu je $18\\,000$ korun. Předem je třeba zaplatit zálohu, která tvoří dvě třetiny ceny zájezdu. Cena za ubytování je stejná jako $75\\,\\%$ zálohy na zájezd. Jaká je cena za ubytování?'},
  new List<String>{'A) $9\\,000$ korun','B) $9\\,500$ korun','C) $9\\,600$ korun','D) $10\\,000$ korun','E) $10\\,500$ korun','F) jiná cena'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $14\\,000\\cdot 0{,}75=10\\,500$ korun → E).','15.2 Pobyt $p$, doprava $\\frac{p}{5}$: $p+\\frac{p}{5}=12\\,000$, tj. $\\frac{6}{5}p=12\\,000$, $p=10\\,000$ korun → D).','15.3 Záloha $\\frac{2}{3}\\cdot 18\\,000=12\\,000$; ubytování $0{,}75\\cdot 12\\,000=9\\,000$ korun → A).'},
  '15.1: E) $10\\,500$ korun; 15.2: D) $10\\,000$ korun; 15.3: A) $9\\,000$ korun',
  6, 9, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7A 2019 – úloha 16',
  new List<String>{'Na čtvercové síti vytváříme ze sirek čtvercové labyrinty podle jednotných pravidel: každá sirka odděluje vždy dvě pole čtvercové sítě; sirky na sebe navazují, začínají ve středu labyrintu a končí v jeho levém dolním rohu; nejmenší labyrint je složen z $8$ sirek a obsahuje $4$ pole; při sestavování následujícího labyrintu se přidá nejmenší možný počet sirek. Na obrázku jsou tři nejmenší labyrinty.','16.1 Vypočtěte, kolik polí čtvercové sítě obsahuje 4. labyrint.','16.2 Vypočtěte, o kolik polí čtvercové sítě je 7. labyrint větší než 6. labyrint.','16.3 Vypočtěte, kolik sirek musíme přidat, chceme-li zvětšit 9. labyrint na 10. labyrint.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif" font-size="14"><polyline points="95,120 119,120 119,96 95,96 71,96" fill="none" stroke="#000" stroke-width="2.6"/><text x="95.0" y="32" text-anchor="middle" font-weight="bold">1. labyrint</text><polyline points="275,120 293,120 293,102 275,102 257,102 257,120 257,138 275,138 293,138 311,138" fill="none" stroke="#000" stroke-width="2.6"/><text x="284.0" y="32" text-anchor="middle" font-weight="bold">2. labyrint</text><polyline points="455,120 468,120 468,107 455,107 442,107 442,120 442,133 455,133 468,133 481,133 481,120 481,107 481,94 468,94 455,94 442,94 429,94" fill="none" stroke="#000" stroke-width="2.6"/><text x="455.0" y="32" text-anchor="middle" font-weight="bold">3. labyrint</text></svg>',
  'labyrinty.svg',
  'Tři nejmenší čtvercové labyrinty ze sirek jako spirály: 1. labyrint 2 krát 2 pole, 2. labyrint 4 krát 4 pole, 3. labyrint 6 krát 6 polí.',
  '1., 2. a 3. labyrint',
  new List<String>{'$n$-tý labyrint je čtverec $2n\\times 2n$ polí, má tedy $(2n)^2=4n^2$ polí (1. má $4$, 2. má $16$, 3. má $36$). Počet sirek přidaných při přechodu na $n$-tý labyrint je $8n$.','16.1 Počet polí 4. labyrintu $4\\cdot 4^2=64$.','16.2 Rozdíl $4\\cdot 7^2-4\\cdot 6^2=196-144=52$ polí.','16.3 Přechod na 10. labyrint: přidáme $8\\cdot 10=80$ sirek.'},
  '16.1: $64$ polí; 16.2: o $52$ polí; 16.3: $80$ sirek',
  4, 6, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
