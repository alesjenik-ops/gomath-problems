String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. náhradní termín (M9D)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2025 M9D · úloha 13',
  new List<String>{'Vlak na druhé koleji má o $3$ vagony více než vlak na první koleji a dvakrát méně vagonů než vlak na třetí koleji. Všechny tři vlaky mají dohromady $41$ vagonů.','O kolik vagonů více má vlak na třetí koleji než vlak na první koleji?'},
  new List<String>{'A) o $8$ vagonů','B) o $10$ vagonů','C) o $11$ vagonů','D) o $13$ vagonů','E) o $14$ vagonů'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'První $v$, druhá $v+3$, třetí $2(v+3)$; $v+(v+3)+2(v+3)=41\\Rightarrow 4v+9=41\\Rightarrow v=8$.','Třetí kolej $2\\cdot11=22$; rozdíl $22-8=14$ vagonů.'},
  'E) o $14$ vagonů',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 14',
  new List<String>{'Jonáš a Beáta zaznamenávali nejvyšší počet jedinců každého ptačího druhu (viz graf). Jonáš spatřil pět druhů, Beáta čtyři z nich. Oba dohromady zaznamenali pěnkav o $6$ méně než sýkor. Jonáš zaznamenal celkem o pětinu více jedinců než Beáta.','Kolik jedinců brhlíka lesního zaznamenala Beáta?'},
  new List<String>{'A) $2$ jedince','B) $3$ jedince','C) $4$ jedince','D) $5$ jedinců','E) více než $5$ jedinců'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 770 265"><path d="M7 4L463 4L463 5L7 5Z" style="fill:#000000"/><path d="M4 36L466 36L466 37L4 37Z" style="fill:#000000"/><path d="M8 91L391 91L391 261L8 261ZM65 221L65 103M62 221L65 221M62 198L65 198M62 174L65 174M62 151L65 151M62 127L65 127M62 103L65 103" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M65 198L327 198M65 174L327 174M65 151L327 151M65 127L327 127M65 103L327 103" style="fill:none;stroke:#a6a6a6;stroke-width:1"/><path d="M75 151L91 151L91 221L75 221ZM128 174L144 174L144 221L128 221ZM180 127L196 127L196 221L180 221ZM232 198L248 198L248 221L232 221ZM285 174L301 174L301 221L285 221Z" style="fill:#595959;stroke:#000000;stroke-width:1"/><path d="M144 100L160 100L160 221L144 221Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M91 174L108 174L108 221L91 221ZM196 127L212 127L212 221L196 221ZM301 151L317 151L317 221L301 221Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><text x="102" y="30" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">VÝCHOZÍ TEXT A GRAF K ÚLOZE 14</text><text x="232" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Jonáš a Beáta se zapojili do programu Ptačí hodinka. Každý v okolí svého krmítka sledoval</text><text x="222" y="69" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">výskyt ptáků v průběhu jedné vybrané hodiny. U každého ptačího druhu zaznamenali</text><text x="156" y="85" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">do grafu vždy nejvyšší počet jedinců spatřených najednou.</text></svg>',
  'obr.svg',
  'Sloupcový graf nejvyššího počtu jedinců pěti ptačích druhů (kos černý, brhlík lesní, sýkora koňadra, červenka obecná, pěnkava obecná) pro Jonáše a Beátu; jeden údaj chybí.',
  '',
  new List<String>{'Z grafu se doplní chybějící údaj pomocí podmínek: pěnkav je o $6$ méně než sýkor a Jonáš zaznamenal celkem o pětinu ($20\\ \\%$) více jedinců než Beáta.','Dopočtem vychází, že Beáta zaznamenala $2$ jedince brhlíka lesního.'},
  'A) $2$ jedince',
  2, 5, '4',
  new List<String>{'zs2','r9','statistika','argumentace','porozumeni','bez-kalkulacky','bezny-zivot'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Pan Zdeněk bydlí posledních pět osmin svého dosavadního života v Plzni, kam se přestěhoval, když mu bylo $27$ let. Kolik let bydlí v Plzni?','15.2 Základní škola je v provozu $84$ let, tedy o $75\\ \\%$ déle než gymnázium. Poměr doby fungování lycea a gymnázia je $2:3$. Kolik let funguje lyceum?','15.3 Součet věků dvojčat a jejich staršího bratra je $99$ let. Každému z dvojčat je o $40\\ \\%$ méně let než bratrovi. Kolik let je každému z dvojčat?'},
  new List<String>{'A) $22$ let','B) $27$ let','C) $32$ let','D) $45$ let','E) $48$ let','F) více než $48$ let'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: v Plzni je $\\frac{5}{8}$ života, přistěhoval se ve $\\frac{3}{8}$ života $=27$ let, celý život $72$; v Plzni $\\frac{5}{8}\\cdot72=45$ let — D.','15.2: gymnázium $\\frac{84}{1{,}75}=48$; lyceum $\\frac{2}{3}\\cdot48=32$ let — C.','15.3: dvojče $=0{,}6B$; $2\\cdot0{,}6B+B=99\\Rightarrow B=45$, dvojče $27$ let — B.'},
  '15.1: D ($45$); 15.2: C ($32$); 15.3: B ($27$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','zlomky','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD25C0T04', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
