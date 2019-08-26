/*
 * [y] hybris Platform
 *
 * Copyright (c) 2018 SAP SE or an SAP affiliate company.  All rights reserved.
 *
 * This software is the confidential and proprietary information of SAP
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with SAP.
 */
package com.mediakind.initialdata.setup.dataimport.impl;

import de.hybris.platform.commerceservices.dataimport.impl.SampleDataImportService;
import de.hybris.platform.core.initialization.SystemSetupContext;


/**
 * Implementation to handle specific Sample Data Import services to Powertools.
 */
public class MediakindSampleDataImportService extends SampleDataImportService
{

	/**
	 * Import content en data
	 *
	 * @param context
	 */
	public void importSampleData(final SystemSetupContext context)
	{
		final String extensionName = context.getExtensionName();

		getSetupImpexService().importImpexFile(
				String.format("/%s/import/sampledata/contentCatalogs/%sContentCatalog/user-groups.impex", extensionName), false);

		getSetupImpexService()
				.importImpexFile(String.format("/%s/import/sampledata/contentCatalogs/%sContentCatalog/cms-content_en.impex",
						extensionName, contentCatalogName), false);
		getSetupImpexService()
				.importImpexFile(String.format("/%s/import/coredata/contentCatalogs/%sContentCatalog/cms-content_en.impex",
						extensionName, contentCatalogName), false);
	}



}
